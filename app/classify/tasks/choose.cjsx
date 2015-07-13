React = require 'react/addons'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">Are there health issues on this page?</div>
      <div className="decision-tree-choices">
        <button type="button" name="decision-tree-confirm-task" onClick={@edit}>New Health Issue</button>
      </div>
    </div>
  
  edit: (e) ->
    @props.onChooseTask()
