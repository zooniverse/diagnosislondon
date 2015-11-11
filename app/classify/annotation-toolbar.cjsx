React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'
Annotation = require './annotation'

AnnotationsSummary = React.createClass
  displayName: 'AnnotationsSummary'
  
  getDefaultProps: ->
    annotations: []
    
  render: ->
    <div>
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
  
  render: ->
    <div className="decision-tree">
        {switch @state.step
          when 'choose'
            <ChooseTask onChooseTask={@edit} onFinish={@finish}>
              <AnnotationsSummary annotations={@props.annotations} deleteTool={@props.deleteTool} />
            </ChooseTask>
          when 'edit'
            <EditTask annotation={@props.annotations[0]} onClick={@selectText} onComplete={@choose}/>
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
    