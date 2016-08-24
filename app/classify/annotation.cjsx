React = require 'react'
{tasks} = require '../config'

TextRange = React.createClass
  displayName: 'TextRange'
  
  render: ->
    annotation = @props.range?.annotation ? ''
    <span>
      {annotation.text} 
    </span>

module.exports = React.createClass
  displayName: 'Annotation'
  
  tasks: tasks
  
  render: ->
    <button className="standard-button annotation #{@props.tool.type}" onClick={@edit}>
      <TextRange range={@props.tool.issue} />
    </button>
  
  edit: (e) ->
    @props.edit @props.tool
    
  delete: (e) ->
    @props.delete @props.tool