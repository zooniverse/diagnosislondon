React = require 'react'

SelectionTool = require '../lib/selection-tool'

module.exports = React.createClass
  displayName: 'SubjectViewer'
  
  mediaSrcs: {}
  
  getInitialState: ->
    text: 'Loading'
  
  componentDidMount: ->
    @loadText @props.subject?.locations
  
  componentWillReceiveProps: (newProps) ->
    @loadText newProps.subject?.locations
  
  render: ->
    image = @mediaSrcs['image/jpeg']
    <div className="readymade-marking-surface-container">
      <div ref = 'textViewer' className="text-viewer">{@state.text}</div>
      {<img  className="subject-image" src={image} alt="" /> if image}
    </div>
  
  createAnnotation: (type) ->
    sel = document.getSelection()
    if sel.rangeCount
      options =
        type: type
        text: @refs.textViewer.getDOMNode()
      tool = new SelectionTool options
  
  fetchOCR: (url) ->
    fetch url
    .then (response)-> return response.text()
    
  loadText: (locations) ->
    @mediaSrcs = {}
    locations?.map (location, i) =>
      @mediaSrcs["#{Object.keys(location)[0]}"] = location["#{Object.keys(location)[0]}"]
    if @mediaSrcs['text/plain']
      @fetchOCR @mediaSrcs['text/plain']
        .then @updateText
    else
      @updateText ''
    
  updateText: (text) ->
    @setState {text}