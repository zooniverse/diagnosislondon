React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'
Annotation = require './annotation'
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
      <Annotation key={tool.id} tool={tool} delete={@props.deleteTool} />
    else
      <p>No issues on this page.</p>
    }
    </div>

module.exports = React.createClass
  displayName: 'ClassificationTask'
  
  defaultInstructions:
    label: 'Identify Health Issues'
    description: "Find a health issue on this page that fits one of the categories below. Your task is to collect all the information on the page about the issue you've found."
  
  getInitialState: ->
    step: 'choose'
    type: 'health'
    instructions: @defaultInstructions
    
  render: ->
    <div>
      <TaskInstructions instructions={@state.instructions} />
      <div className="readymade-classification-interface">
        <div className="readymade-decision-tree-container">
          <div className="decision-tree">
            {switch @state.step
              when 'choose'
                <div>
                  <ChooseTask onChooseTask={@edit} onFinish={@finish} />
                  <AnnotationsSummary annotations={@props.annotations} deleteTool={@props.deleteTool} />
                </div>
              when 'edit'
                <EditTask annotation={@props.annotations[0]} onClick={@selectText} onComplete={@choose}/>
            }
          </div>
        </div>
          {@props.children}
      </div>
    </div>
  
  edit: (type) ->
    @props.addTool type
    @setState 
      step: 'edit'
      type: type
      instructions: tasks[type]
  
  choose: ->
    @props.annotations.map (annotation) =>
      @props.deleteTool annotation if annotation.empty()
      for ranges in annotation.ranges
        ranges.map (range) -> range.el.classList.add 'complete'
      
    @setState 
      step: 'choose'
      type: null
      instructions: @defaultInstructions
  
  finish: ->
    @props.onFinish()
  
  selectText: (e) ->
    @props.onClick e
    