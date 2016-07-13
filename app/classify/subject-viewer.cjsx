React = require 'react'

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
    classList=["readymade-marking-surface-container"]
    classList.push "current" if @props.isCurrent
    image = @mediaSrcs['image/jpeg']
    <div className={classList.join ' '}>
      <div className="text-viewer">
        <div data-subject={@props.subject.id}>{@state.text}</div>
      </div>
      <div className="subject-image">
        <h3>Scanned page</h3>
        {<img src={image} alt="" /> if image}
      </div>
    </div>
  
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