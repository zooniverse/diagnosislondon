React = require 'react'

module.exports = React.createClass
  displayName: 'Profile'
  
  getDefaultProps: ->
    user: null
  
  render: ->
    <div>
      {if @props.user?
        <p>Yo, {@props.user.display_name}!</p>
      }
    </div>