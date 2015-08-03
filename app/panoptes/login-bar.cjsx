React = require 'react'
alert = require './alert'
LoginDialog = require './login-dialog'

module.exports = React.createClass
  displayName: 'LoginBar'
  client_id: '400ef4a4e543a717d370c4304a460eeb1ac4c9fc1b00897b92a67da5818a1603'
  app_uri: 'http://preview.zooniverse.org/wellcome'

  render: ->
    <div className="login-bar">
      <a className="secret-button" href="https://panoptes.zooniverse.org/oauth/authorize?response_type=token&client_id=#{@client_id}&redirect_uri=#{@app_uri}">Sign in</a>
    </div>
