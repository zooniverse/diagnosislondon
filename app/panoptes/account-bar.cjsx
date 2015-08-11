React = require 'react'
Avatar = require './avatar'

ENTER = 13
UP = 38
DOWN = 40

module.exports = React.createClass
  displayName: 'AccountBar'
  
  getInitialState: ->
    expanded: false

  render: ->
    <div className="account-bar" onKeyDown={@navigateMenu}>
      <div className="account-info">
        <button aria-expanded={@state.expanded} aria-haspopup="true" className="secret-button display-name" onClick={@toggleAccountMenu}>
          <strong>{@props.user.display_name}</strong>
        </button>
        <Avatar user={@props.user} />
        <a href="#" className="message-link"><i className="fa fa-envelope#{if @state.unread then '' else '-o'}" /></a>
      </div>
      <div aria-hidden={!@state.expanded} aria-label="account menu" className="account-menu" ref="accountMenu">
        <a className="secret-button" href="https://zooniverse.org/#/settings">Account</a>
        <button className="secret-button sign-out-button" type="button" onClick={@handleSignOutClick}>Sign out</button>
      </div>
    </div>

  handleSignOutClick: ->
    @props.auth.signOut()

  toggleAccountMenu: ->
    @setState expanded: !@state.expanded
  
  navigateMenu: (e) ->
    return unless @state.expanded
    focusables = [@getDOMNode().querySelector 'button']
    focusables.push control for control in @getDOMNode().querySelectorAll '.account-menu button, .account-menu a[href]'
    focus_index = i for control, i in focusables when control == document.activeElement
    switch e.which
      when UP
        new_index = Math.max 0, focus_index - 1
        focusables[new_index].focus()
        e.preventDefault()
      when DOWN
        new_index = Math.min focusables.length - 1, focus_index + 1
        focusables[new_index].focus()
        e.preventDefault()

