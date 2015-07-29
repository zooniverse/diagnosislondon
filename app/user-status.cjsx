React = require 'react'
AccountBar = require './panoptes/account-bar'
LoginBar = require './panoptes/login-bar'

module.exports = React.createClass
  displayName: 'UserStatus'
  
  getDefaultProps: ->
    user: null
    
  getInitialState: ->
    user: null
  
  componentWillMount: ->
    @setState user: @props.user
    
  componentWillReceiveProps: (newProps) ->
    @setState user: newProps.user unless newProps.user is @props.user
    
  
  render: ->
    if @state.user?
      <AccountBar user={@state.user} auth={@props.auth} />
    else
      <LoginBar auth={@props.auth} />