React = require 'react'
{tasks} = require '../config'

TextRange = React.createClass
  displayName: 'TextRange'
  
  render: ->
    annotation = @props.tool.annotation
    <li className="highlight #{annotation.type}">
      {annotation.text} 
    </li>

module.exports = React.createClass
  displayName: 'Annotation'
  
  tasks: tasks
  
  render: ->
    <div>
      {@tasks[@props.tool.type].label} <button ref="delete" onClick={@delete}>X</button>
      <ul>
      {for type, range of @props.tool.ranges
        <TextRange key={range.id} tool={range} />
      }
      </ul>
    </div>
  
  delete: (e) ->
    @props.delete @props.tool