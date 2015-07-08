React = require 'react/addons'

module.exports = React.createClass
  displayName: 'AnnotationTool'
  
  render: ->
    annotation = @props.tool.annotation
    <p className="highlight #{annotation.type}">
      {annotation.text} <button ref="delete" onClick={@delete}>X</button>
    </p>
  
  delete: (e) ->
    @props.deleteTool @props.tool