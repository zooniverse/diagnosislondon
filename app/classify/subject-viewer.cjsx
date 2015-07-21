React = require 'react'

SelectionTool = require '../lib/selection-tool'

module.exports = React.createClass
  displayName: 'SubjectViewer'
  
  getInitialState: ->
    text: 'Loading'
  
  componentDidMount: ->
    text_url = @props.subject.locations[0]['text/plain']
    @fetchOCR text_url
    .then @updateText
  
  componentWillReceiveProps: (newProps) ->
    text_url = newProps.subject.locations[0]['text/plain']
    @fetchOCR text_url
    .then @updateText
  
  render: ->
    image = @props.subject.locations[1]['image/jpeg']
    <div className="readymade-marking-surface-container">
      <div ref = 'textViewer' className="text-viewer">{@state.text}</div>
      <img  className="subject-image" src={image} alt="" />
    </div>
  
  createAnnotation: (type) ->
    sel = window.getSelection()
    if sel.type is 'Range'
      options =
        type: type
        text: @refs.textViewer.getDOMNode()
      tool = new SelectionTool options
  
  fetchOCR: (url) ->
    fetch url
    .then (response)-> return response.text()
    
  updateText: (text) ->
    @setState {text}