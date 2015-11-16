React = require 'react'
{tasks} = require '../config'

TextRange = React.createClass
  displayName: 'TextRange'
  
  render: ->
    annotation = @props.range.annotation
    <li className="highlight #{annotation.type}">
      {annotation.text} 
    </li>

module.exports = React.createClass
  displayName: 'Annotation'
  
  tasks: tasks
  
  render: ->
    <div className="annotation">
      {@tasks[@props.tool.type].label} <button className="secret-button" aria-label='Delete' ref="delete" onClick={@delete}>X</button>
      <ul>
        <TextRange range={@props.tool.issue} />
      </ul>
    </div>
  
  delete: (e) ->
    @props.delete @props.tool