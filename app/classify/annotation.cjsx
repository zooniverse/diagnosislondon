React = require 'react/addons'
TextRange = React.createClass
  displayName: 'TextRange'
  
  render: ->
    annotation = @props.tool.annotation
    <li className="highlight #{annotation.type}">
      {annotation.text} 
    </li>

module.exports = React.createClass
  displayName: 'Annotation'
    
  componentWillUnmount: ->
    range.destroy() for range in @props.tool.ranges
  
  render: ->
    <div>
      Health Issue <button ref="delete" onClick={@delete}>X</button>
      <ul>
      {@props.tool.ranges.map (range) =>
        <TextRange key={range.id} tool={range} />
      }
      </ul>
    </div>
  
  delete: (e) ->
    @props.delete @props.tool