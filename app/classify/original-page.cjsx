React = require 'react'

module.exports = React.createClass
  displayName: 'OriginalPage'
  
  render: ->
    ids = @props.subject.metadata.image.split '.'
    ids = ids[0].split '_'
    <a href="http://wellcomelibrary.org/moh/report/#{ids[0]}#?asi=#{ids[1]}&ai=#{ids[2]}" target="wellcome" className="readymade-clickable" title="Original page">
      <span className="fa fa-file"></span>
      Original page
    </a>