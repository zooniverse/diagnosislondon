React = require 'react'
{tasks} = require '../config'

TextRange = React.createClass
  displayName: 'TextRange'
  
  render: ->
    annotation = @props.range.annotation
    <p className="text-selection">
      {annotation.text} 
    </p>

module.exports = React.createClass
  displayName: 'Annotation'
  
  tasks: tasks
  
  render: ->
    <div className="annotation #{@props.tool.type}">
      {@tasks[@props.tool.type].label} <button className="secret-button" aria-label='Edit' onClick={@edit}><span className="fa fa-pencil-square-o"></span></button>
      <TextRange range={@props.tool.issue} />
    </div>
  
  edit: (e) ->
    @props.edit @props.tool
    
  delete: (e) ->
    @props.delete @props.tool