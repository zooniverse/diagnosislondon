React = require 'react/addons'
subject = require '../test-subject'

AnnotationTool = require '../lib/annotation-tool'

module.exports = React.createClass
  displayName: 'SubjectViewer'
  
  tool_options: {}
  
  getInitialState: ->
    text: subject.text
  
  render: ->
    <div className="readymade-marking-surface-container">
        <pre ref = 'textViewer' className="text-viewer"  onMouseUp = {@createAnnotation}>{@state.text}</pre>
    </div>
  
  createAnnotation: () ->
    sel = window.getSelection()
    if sel.type is 'Range'
      options =
        sel: sel
        type: @props.value
      options[key] = value for key, value of @tool_options
      tool = new AnnotationTool @refs.textViewer.getDOMNode(), options
      @props.addTool tool