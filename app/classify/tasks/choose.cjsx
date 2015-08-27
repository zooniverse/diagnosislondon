React = require 'react'
{tasks} = require '../../config'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">Add annotations to this page.</div>
      <ul className="decision-tree-choices">
        {for key, task of tasks
          <li key={key} className="decision-tree-choice">
            <button className="readymade-choice-clickable" value={key} onClick={@edit}>
              <span className="readymade-choice-label">{task.label}</span>
            </button> 
          </li>
        }
        <button type="button" name="decision-tree-confirm-task" onClick={@finish}>Finish page</button>
      </ul>
    </div>
  
  edit: (e) ->
    @props.onChooseTask e.currentTarget.value
  
  finish: ->
    @props.onFinish()

