React = require 'react'

module.exports = React.createClass
  displayName: 'LoginBar'
  
  signIn: ->
    @props.auth.signIn("#{window.location}")

  render: ->
    <div className="login-bar">
      <button className="secret-button" onClick={@signIn}>Sign in</button>
    </div>

