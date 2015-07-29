React = require 'react'

module.exports = React.createClass
  displayName: 'Profile'
  
  getDefaultProps: ->
    user: null
    
  getInitialState: ->
    user: null
  
  componentWillMount: ->
    @setState user: @props.user
  
  componentWillReceiveProps: (newProps) ->
    @setState user: newProps.user unless newProps.user is @props.user

  render: ->
    <div>
      {if @state.user?
        <p>Yo, {@state.user.display_name}!</p>
      }
    </div>