React = require 'react'
FilterTask = require './tasks/filter'
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
    {<h2>Health issues</h2> if @props.annotations.length}
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
    relevant: null
    step: 'filter'
    type: 'health'
    instructions: @defaultInstructions
    annotations: []
    
  render: ->
    children = React.Children.map @props.children, (child) => React.cloneElement child, task: @state.step
    <div>
      <TaskInstructions instructions={@state.instructions} />
      <div className="readymade-classification-interface">
        <div className="readymade-decision-tree-container">
          <div className="decision-tree">
            {switch @state.step
              when 'filter'
                <FilterTask onComplete={@filter} />
              when 'choose'
                <div>
                  <ChooseTask onChooseTask={@create} onBack={@reset} onFinish={@finish} />
                </div>
              when 'edit'
                <EditTask annotation={@currentAnnotation()} onChange={@onChange} onComplete={@choose}/>
            }
          </div>
        </div>
          {children}
        <div className="readymade-decision-tree-container">
          <div className="decision-tree">
            {switch @state.step
              when 'choose', 'edit'
                <div>
                  <AnnotationsSummary annotations={@state.annotations} deleteTool={@deleteAnnotation} onEdit={@edit} />
                </div>
            }
          </div>
        </div>
      </div>
    </div>
  
  onChange: (annotation) ->
    @props.onChange annotation
    
    annotations = @state.annotations
    annotations.shift()
    annotations.unshift annotation
    @setState {annotations}
    
  filter: (choice) ->
    switch choice
      when 'yes'
        @setState
          relevant: 'yes'
          step: 'choose'
          type: null
          instructions: @defaultInstructions
      when 'no'
        @setState relevant: 'no', @finish

  create: (type) ->
    @newAnnotation type
    @setState 
      step: 'edit'
      type: type
      instructions: tasks[type]
  
  edit: (annotation) ->

    if @state.step is 'edit'
      @completeAnnotation @currentAnnotation(), => @editAnnotation annotation
    else
      @editAnnotation annotation
    @props.onChange annotation
  
  choose: (annotation) ->
    @completeAnnotation annotation
      
    @setState 
      step: 'choose'
      type: null
      instructions: @defaultInstructions
    
    @props.onChange new AnnotationTool
  
  reset: ->
    annotation.destroy() for annotation in @state.annotations
    step = 'filter'
    annotations = []
    @setState {annotations, step}
    
  finish: ->
    marking_annotations = []
    @state.annotations.map (annotation, i) ->
      marking_annotations.push annotation.value()
    annotations =
      T1: @state.relevant
      T2: marking_annotations 
    @props.onFinish annotations
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    step = 'filter'
    @setState {annotations, step}
  
  newAnnotation: (type) ->
    annotations = @state.annotations
    annotation = new AnnotationTool type
    annotation.addIssue()
    annotations.unshift annotation
    @setState {annotations}
    @props.onChange annotation
  
  editAnnotation: (annotation) ->
    annotation.issue?.el.classList.remove 'complete'
    for type, ranges of annotation.subtasks
      ranges.map (range) -> range.el.classList.remove 'complete'
    
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    annotations.unshift annotation
    @setState 
      step: 'edit'
      type: annotation.type
      instructions: tasks[annotation.type]
      annotations: annotations
      
  deleteAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    annotation.destroy()
    @setState {annotations}
  
  currentAnnotation: ->
    @state.annotations[0]
  
  completeAnnotation: (annotation, callback = () -> ) ->
    annotations = @state.annotations
    annotations.shift()
    
    if annotation.empty()
      annotation.destroy()
    else
      annotation.issue?.el.classList.add 'complete'
      for type, ranges of annotation.subtasks
        ranges.map (range) -> range.el.classList.add 'complete'
      annotations.unshift annotation
    
    @setState {annotations}, callback
    
    