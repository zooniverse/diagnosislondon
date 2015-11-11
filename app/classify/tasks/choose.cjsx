React = require 'react'
{tasks} = require '../../config'

module.exports = React.createClass
  displayName: 'ChooseTask'
  
  instructions:
    label: 'Identify Health Issues'
    description: "Find a health issue on this page that fits one of the categories below. Your task is to collect all the information on the page about the issue you've found."
  
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

