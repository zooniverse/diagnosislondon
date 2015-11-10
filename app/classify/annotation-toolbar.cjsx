React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'
Annotation = require './annotation'

TaskInstructions = React.createClass
  displayName: 'TaskInstructions'
  
  render: ->
    <div className="task-instructions">
      <h2>{@props.task?.label}</h2>
      <p>{@props.task?.description}</p>
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
  displayName: 'AnnotationToolbar'
  
  getInitialState: ->
    step: 'choose'
    type: 'health'
    
  componentDidUpdate: ->
    React.render <TaskInstructions task={@refs.currentTask.instructions} />, document.querySelector '#task-instructions'
    
  render: ->
    <div className="decision-tree">
        {switch @state.step
          when 'choose'
            <div>
              <ChooseTask ref="currentTask" onChooseTask={@edit} onFinish={@finish} />
              <AnnotationsSummary annotations={@props.annotations} deleteTool={@props.deleteTool} />
            </div>
          when 'edit'
            <EditTask ref="currentTask" annotation={@props.annotations[0]} onClick={@selectText} onComplete={@choose}/>
        }
    </div>
  
  edit: (type) ->
    @props.addTool type
    @setState 
      step: 'edit'
      type: type
  
  choose: ->
    @props.annotations.map (annotation) =>
      @props.deleteTool annotation if annotation.empty()
      for ranges in annotation.ranges
        ranges.map (range) -> range.el.classList.add 'complete'
      
    @setState step: 'choose'
  
  finish: ->
    @props.onFinish()
  
  selectText: (e) ->
    @props.onClick e
    