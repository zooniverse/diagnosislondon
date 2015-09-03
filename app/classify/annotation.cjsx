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
      {@tasks[@props.tool.type].label} <button ref="delete" onClick={@delete}>X</button>
      <ul>
      {for type, selections of @props.tool.ranges
        selections.map (range) ->
          <TextRange key={range.id} range={range} />
      }
      </ul>
    </div>
  
  delete: (e) ->
    @props.delete @props.tool