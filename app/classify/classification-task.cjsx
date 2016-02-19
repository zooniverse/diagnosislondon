React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'
Annotation = require './annotation'
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
    {if @props.annotations.length then @props.annotations.map (tool) =>
      <Annotation key={tool.id} tool={tool} delete={@props.deleteTool} edit={@edit} />
    else
      <p>No issues on this page yet.</p>
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
                <EditTask annotation={@state.annotations[0]} onChange={@props.onChange} onComplete={@choose}/>
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
    @props.onChange tool
  
  choose: (annotation) ->
    annotations = @state.annotations
    annotations.shift()
    
    if annotation.empty()
      annotation.destroy()
    else
      annotation.issue?.el.classList.add 'complete'
      for type, ranges of annotation.subtasks
        ranges.map (range) -> range.el.classList.add 'complete'
      annotations.unshift annotation
      
    @setState 
      step: 'choose'
      type: null
      instructions: @defaultInstructions
      annotations: annotations
    
    @props.onChange new AnnotationTool
  
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
    