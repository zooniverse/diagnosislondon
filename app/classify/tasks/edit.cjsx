React = require 'react'
{tasks} = require '../../config'

ToolList = React.createClass
  displayName: 'ToolList'
  
  getInitialState: ->
    selections: {}
    
  getDefaultProps: ->
    disabled: false
    tools: []
  
  render: ->
    <ul className="decision-tree-choices">
    {@props.tools.map (tool) =>
      label = @state.selections[tool.value] ? tool.label
      <li key={tool.value} className="decision-tree-choice">
        <button className="readymade-choice-clickable" value={tool.value} disabled={@props.disabled} onClick={@selectText}>
          <span className="readymade-choice-label">{label}</span>
        </button>
        {if tool.subtasks
          <ToolList tools={tool.subtasks} disabled={label == tool.label} onClick={@props.onClick} />
        }
      </li>}
    </ul>
  
  selectText: (e) ->
    selection = window.getSelection().toString() ? null
    return unless selection
    selections = @state.selections
    type = e.currentTarget.value
    selections[type] = selection
    @setState {selections}
    
    @props.onClick e

module.exports = React.createClass
  displayName: 'EditTask'
  
  getInitialState: ->
    selections: {}
  
  render: ->
    {tools} = tasks[@props.type]
    <div className="decision-tree-task">
      <div className="decision-tree-question">Select text and mark it by clicking a button:</div>
      <ToolList tools={tools} onClick={@props.onClick}>
      </ToolList>
      <div className="decision-tree-confirmation">
        <button type="button" name="decision-tree-confirm-task" onClick={@done}>Done</button>
      </div>
    </div>
    
  done: (e) ->
    @props.onComplete()