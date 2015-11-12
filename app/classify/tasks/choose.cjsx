React = require 'react'
{tasks} = require '../../config'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">
        To get started first select the category
      </div>
      <ul className="decision-tree-choices">
        {for key, task of tasks
          <li key={key} className="decision-tree-choice">
            <button className="readymade-choice-clickable standard-button" value={key} onClick={@edit}>
              <span className="readymade-choice-label">{task.label}</span>
            </button> 
          </li>
        }
        {@props.children}
        <button type="button" className="major-button" onClick={@finish}>Finish page</button>
      </ul>
    </div>
  
  edit: (e) ->
    @props.onChooseTask e.currentTarget.value
  
  finish: ->
    @props.onFinish()

