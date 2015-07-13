React = require 'react'
subject = require '../test-subject'

SelectionTool = require '../lib/selection-tool'

module.exports = React.createClass
  displayName: 'SubjectViewer'
  
  getInitialState: ->
    text: subject.text
  
  render: ->
    <div className="readymade-marking-surface-container">
      <pre ref = 'textViewer' className="text-viewer">{@state.text}</pre>
      <img  className="subject-image" src="http://demo.zooniverse.org/wellcome/offline/actual_d01aae95-68a1-4518-b509-3c159ffb40c9.jpg" alt="" />
    </div>
  
  createAnnotation: (type) ->
    sel = window.getSelection()
    if sel.type is 'Range'
      options =
        type: type
        text: @refs.textViewer.getDOMNode()
      tool = new SelectionTool options