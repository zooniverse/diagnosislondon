React = require 'react'
alert = require './alert'
LoginDialog = require './login-dialog'

module.exports = React.createClass
  displayName: 'LoginBar'

  render: ->
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
