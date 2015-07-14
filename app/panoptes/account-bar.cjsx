React = require 'react'
Avatar = require './avatar'

module.exports = React.createClass
  displayName: 'AccountBar'


  render: ->
    <div className="account-bar">
      <div className="account-info">
        <span className="display-name"><strong>{@props.user.display_name}</strong></span>
        <Avatar user={@props.user} />
      </div>
      <div className="account-menu" ref="accountMenu">
        <button className="secret-button sign-out-button" type="button" onClick={@handleSignOutClick}>Sign out</button>
      </div>
      </div>

  handleSignOutClick: ->
    @props.auth.signOut()

  toggleAccountMenu: ->
    accountMenu = @refs.accountMenu
    React.findDOMNode(accountMenu).classList.toggle 'show'
