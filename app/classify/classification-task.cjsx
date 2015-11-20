React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'
Annotation = require './annotation'
SelectionTool = require '../lib/selection-tool'
AnnotationTool = require '../lib/annotation-tool'
{tasks} = require '../config'

TaskInstructions = React.createClass
  displayName: 'TaskInstructions'
  
  render: ->
    <div className="task-instructions">
      <h2>{@props.instructions.label}</h2>
      <p>{@props.instructions.description}</p>
    </div>

AnnotationsSummary = React.createClass
  displayName: 'AnnotationsSummary'
  
  getDefaultProps: ->
    annotations: []
    
  render: ->
    <div className="annotation-summary">
      <h2>Health issues on this page</h2>
    {if @props.annotations.length then @props.annotations.map (tool) =>
      <Annotation key={tool.id} tool={tool} delete={@props.deleteTool} edit={@edit} />
    else
      <p>No issues on this page.</p>
    }
    </div>
  
  edit: (tool) ->
    @props.onEdit tool

module.exports = React.createClass
  displayName: 'ClassificationTask'
  
  defaultInstructions:
    label: 'Identify Health Issues'
    description: "Find a health issue on this page that fits one of the categories below. Your task is to collect all the information on the page about the issue you've found."
  
  getInitialState: ->
    step: 'choose'
    type: 'health'
    instructions: @defaultInstructions
    annotations: []
    
  render: ->
    <div>
      <TaskInstructions instructions={@state.instructions} />
      <div className="readymade-classification-interface">
        <div className="readymade-decision-tree-container">
          <div className="decision-tree">
            {switch @state.step
              when 'choose'
                <div>
                  <ChooseTask onChooseTask={@create} onFinish={@finish} />
                  <AnnotationsSummary annotations={@state.annotations} deleteTool={@deleteAnnotation} onEdit={@edit} />
                </div>
              when 'edit'
                <EditTask annotation={@state.annotations[0]} addText={@addText} deleteText={@deleteText} onComplete={@choose}/>
            }
          </div>
        </div>
          {@props.children}
      </div>
    </div>
  
  create: (type) ->
    @newAnnotation type
    @setState 
      step: 'edit'
      type: type
      instructions: tasks[type]
  
  edit: (tool) ->
    tool.issue?.el.classList.remove 'complete'
    for type, ranges of tool.subtasks
      ranges.map (range) -> range.el.classList.remove 'complete'
    @editAnnotation tool
    @setState 
      step: 'edit'
      type: tool.type
      instructions: tasks[tool.type]
  
  choose: ->
    @state.annotations.map (annotation) =>
      @deleteAnnotation annotation if annotation.empty()
      annotation.issue?.el.classList.add 'complete'
      for type, ranges of annotation.subtasks
        ranges.map (range) -> range.el.classList.add 'complete'
      
    @setState 
      step: 'choose'
      type: null
      instructions: @defaultInstructions
  
  finish: ->
    task_annotations = {}
    @state.annotations.map (annotation, i) ->
      task_annotations[annotation.type] ?= []
      task_annotations[annotation.type].push annotation.value()
    task_annotations[task] ?= [] for task of tasks
    @props.onFinish task_annotations
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    @setState {annotations}
  
  addText: (e) ->
    textRange = @createSelection e.currentTarget.value
    return unless textRange?
    annotations = @state.annotations
    currentAnnotation = annotations.shift()
    if textRange.type == 'issue'
      currentAnnotation.addIssue textRange
    else
      currentAnnotation.addSubtask textRange
    annotations.unshift currentAnnotation
    @setState {annotations}
  
  deleteText: (textRange) ->
    return unless textRange?
    annotations = @state.annotations
    currentAnnotation = annotations.shift()
    if textRange.type == 'issue'
      currentAnnotation.deleteIssue textRange
    else
      currentAnnotation.deleteSubtask textRange
    annotations.unshift currentAnnotation
    @setState {annotations}
  
  newAnnotation: (type) ->
    annotations = @state.annotations
    annotations.unshift new AnnotationTool type
    @setState {annotations}
  
  editAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    annotations.unshift annotation
    @setState {annotations}
  
  deleteAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    annotation.destroy()
    @setState {annotations}
  
  createSelection: (type) ->
    sel = document.getSelection()
    if sel.rangeCount
      options =
        type: type
      tool = new SelectionTool options
    