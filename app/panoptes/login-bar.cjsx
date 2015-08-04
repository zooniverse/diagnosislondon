React = require 'react'
alert = require './alert'
LoginDialog = require './login-dialog'

module.exports = React.createClass
  displayName: 'LoginBar'
  client_id: '324bbe871acddc1457878b111a6772e25556928644c5ef9ee1784035ad0b0554'
  app_uri: window.location

  render: ->
    <div className="login-bar">
      <a className="secret-button" href="https://panoptes.zooniverse.org/oauth/authorize?response_type=token&client_id=#{@client_id}&redirect_uri=#{@app_uri}">Sign in</a>
    </div>
