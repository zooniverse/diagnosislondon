React = require 'react'
{tasks} = require '../../config'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">
        To get started first select the category
      </div>
      <button type="button" className="decision-tree-choice major-button" onClick={@back}>Back</button>
      <ul className="decision-tree-choices">
        {for key, task of tasks
          <li key={key} className="decision-tree-choice">
            <button className="readymade-choice-clickable standard-button" value={key} onClick={@edit}>
              <span className="readymade-choice-label">{task.label}</span>
            </button> 
          </li>
        }
      </ul>
      {@props.children}
      <button type="button" className="major-button" onClick={@finish}>Finish page</button>
    </div>
  
  edit: (e) ->
    @props.onChooseTask e.currentTarget.value
  
  back: ->
    @props.onBack()

  finish: ->
    @props.onFinish()

