React = require 'react/addons'

module.exports = React.createClass
  displayName: 'Profile'

  render: ->
    <div>
      {if @props.user?
        <p>Yo, {@props.user.display_name}!</p>
      }
    </div>