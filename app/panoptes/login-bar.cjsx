React = require 'react'
config = require '../config'

module.exports = React.createClass
  displayName: 'LoginBar'
  client_id: config.panoptes.appID
  app_uri: window.location

  render: ->
    <div className="login-bar">
      <a className="secret-button" href="#{config.panoptes.host}/oauth/authorize?response_type=token&client_id=#{@client_id}&redirect_uri=#{@app_uri}">Sign in</a>
    </div>

