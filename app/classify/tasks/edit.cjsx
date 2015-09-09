React = require 'react'
{tasks} = require '../../config'

TextSelection = React.createClass
  displayName: 'TextSelection'
  
  getDefaultProps: ->
    range: {}
  
  render: ->
    <p>{@props.range.annotation.text} <button aria-label='Delete' onClick={@delete}>X</button></p>
  
  delete: (e) ->
    @props.onDelete @props.range

ToolList = React.createClass
  displayName: 'ToolList'
    
  getInitialState: ->
    ranges: []
    
  getDefaultProps: ->
    disabled: false
    tools: []
    annotation: {}
  
  componentWillMount: ->
    @setState ranges: @props.annotation.ranges
  
  render: ->
    <ul className="decision-tree-choices">
    {@props.tools.map (tool) =>
      <li key={tool.value} className="decision-tree-choice">
        <button className="readymade-choice-clickable" value={tool.value} disabled={@props.disabled} onClick={@selectText}>
          <span className="readymade-choice-label">{tool.label}</span>
        </button>
        {if @state.ranges[tool.value]?
          <TextSelection key="selection-#{i}" range={range} onDelete={@deleteText}/> for range, i in @state.ranges[tool.value]
        }
        {if tool.subtasks
          <ToolList annotation={@props.annotation} tools={tool.subtasks} disabled={!@state.ranges[tool.value]?} onClick={@props.onClick} />
        }
      </li>}
    </ul>
  
  selectText: (e) ->
    @props.onClick e
  
  deleteText: (range) ->
    @props.annotation.deleteRange range
    @setState ranges: @props.annotation.ranges

module.exports = React.createClass
  displayName: 'EditTask'
  
  render: ->
    {tools} = tasks[@props.annotation.type]
    <div className="decision-tree-task">
      <div className="decision-tree-question">Select text and mark it by clicking a button:</div>
      <ToolList annotation={@props.annotation} tools={tools} onClick={@props.onClick}>
      </ToolList>
      <div className="decision-tree-confirmation">
        <button type="button" name="decision-tree-confirm-task" onClick={@done}>Done</button>
      </div>
    </div>
    
  done: (e) ->
    @props.onComplete()