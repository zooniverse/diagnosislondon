React = require 'react'
config = require '../config'
alert = require './alert'
LoginDialog = require './login-dialog'

module.exports = React.createClass
  displayName: 'LoginBar'
  client_id: config.panoptes.appID
  app_uri: window.location

  render: ->
    switch config.auth_mode
      when 'oauth'
        <div className="login-bar">
          <a className="secret-button" href="#{config.panoptes.host}/oauth/authorize?response_type=token&client_id=#{@client_id}&redirect_uri=#{@app_uri}">Sign in</a>
        </div>
      when 'panoptes'
        <div className="login-bar">
          <button type="button" className="secret-button" onClick={@showLoginDialog.bind this, 'sign-in'}>
            Sign in
          </button>&emsp;
          <button type="button" className="secret-button" onClick={@showLoginDialog.bind this, 'register'}>
            Register
          </button>
        </div>
  
  showLoginDialog: (which) ->
    alert (resolve) =>		
      <LoginDialog auth={@props.auth} which={which} onSuccess={resolve} />
