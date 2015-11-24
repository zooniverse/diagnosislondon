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
      {@tasks[@props.tool.type].label} <button className="secret-button" aria-label='Edit' onClick={@edit}><span className="fa fa-pencil-square-o"></span></button>
      <ul>
        <TextRange range={@props.tool.issue} />
      </ul>
    </div>
  
  edit: (e) ->
    @props.edit @props.tool
    
  delete: (e) ->
    @props.delete @props.tool