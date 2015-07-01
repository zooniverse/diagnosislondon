React = require 'react/addons'

module.exports = React.createClass
  displayName: 'Profile'

  render: ->
    <div>
      <p>Yo, {@props.user.display_name}!</p>
    </div>