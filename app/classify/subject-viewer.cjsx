React = require 'react/addons'
subject = require '../test-subject'

module.exports = React.createClass
  displayName: 'SubjectViewer'
  
  getInitialState: ->
    text: subject.text
  
  render: ->
    <div className="readymade-marking-surface-container">
        <pre className="text-viewer">{@state.text}</pre>
    </div>