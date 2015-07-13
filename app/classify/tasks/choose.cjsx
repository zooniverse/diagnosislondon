React = require 'react/addons'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  choices: [{
      label: 'New Health Issue'
      value: 'health'
    },{
      label: 'New Welfare Issue'
      value: 'welfare'
    }]
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">Add annotations to this page.</div>
      <div className="decision-tree-choices">
        {@choices.map (choice) =>
          <div key={choice.value} className="decision-tree-choice">
            <button className="readymade-choice-clickable" value={choice.value} onClick={@edit}>
              <span className="readymade-choice-label">{choice.label}</span>
            </button> 
          </div>
        }
        <button type="button" name="decision-tree-confirm-task" onClick={@finish}>Finish page</button>
      </div>
    </div>
  
  edit: (e) ->
    @props.onChooseTask e.currentTarget.value
  
  finish: ->
    @props.onFinish()

