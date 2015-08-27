React = require 'react'
{tasks} = require '../../config'

module.exports = React.createClass
  displayName: 'EditTask'
  
  getInitialState: ->
    selections: {}
  
  render: ->
    {tools} = tasks[@props.type]
    <div className="decision-tree-task">
      <div className="decision-tree-question">Select text and mark it by clicking a button:</div>
      <ul className="decision-tree-choices">
        {tools.map (tool) =>
          label = @state.selections[tool.value] ? tool.label
          <li key={tool.value} className="decision-tree-choice">
            <button className="readymade-choice-clickable" value={tool.value} onClick={@selectText}>
              <span className="readymade-choice-label">{label}</span>
            </button> 
          </li>
        }
      </ul>
      <div className="decision-tree-confirmation">
        <button type="button" name="decision-tree-confirm-task" onClick={@done}>Done</button>
      </div>
    </div>
  
  selectText: (e) ->
    selection = window.getSelection().toString() ? null
    return unless selection
    selections = @state.selections
    type = e.currentTarget.value
    selections[type] = selection
    @setState {selections}
    
    @props.onClick e
    
  done: (e) ->
    @props.onComplete()