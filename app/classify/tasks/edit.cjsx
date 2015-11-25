React = require 'react'
SelectionTool = require '../../lib/selection-tool'
{tasks} = require '../../config'

TextSelection = React.createClass
  displayName: 'TextSelection'
  
  getDefaultProps: ->
    range: {}
  
  render: ->
    <p className="text-selection"><button className="secret-button" aria-label='Delete' onClick={@delete}>X</button> {@props.range.annotation.text}</p>
  
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
    ranges = {}
    ranges[key] = @props.annotation.subtasks[key] for key of @props.annotation.subtasks
    ranges.issue = [@props.annotation.issue] if @props.annotation.issue?
    @setState {ranges}
  
  componentWillReceiveProps: (newprops) ->
    ranges = {}
    ranges[key] = newprops.annotation.subtasks[key] for key of newprops.annotation.subtasks
    ranges.issue = [newprops.annotation.issue] if newprops.annotation.issue?
    @setState {ranges}
    
  
  render: ->
    <ul className="decision-tree-choices">
    {@props.tools.map (tool) =>
      <li key={tool.value} className="decision-tree-choice">
        <button className="readymade-choice-clickable standard-button" value={tool.value} disabled={@props.disabled} onClick={@selectText}>
          <span className="readymade-choice-label">{tool.label}</span>
        </button>
        {if @state.ranges[tool.value]?
          <TextSelection key="selection-#{i}" range={range} onDelete={@deleteText}/> for range, i in @state.ranges[tool.value]
        }
        {if tool.subtasks
          <ToolList annotation={@props.annotation} tools={tool.subtasks} disabled={!@state.ranges[tool.value]?} addText={@props.addText} deleteText={@props.deleteText} />
        }
      </li>}
    </ul>
  
  selectText: (e) ->
    @props.addText e
  
  deleteText: (range) ->
    @props.deleteText range

module.exports = React.createClass
  displayName: 'EditTask'
  
  instructions: "To collect all the information about this health issue, highlight a piece of relevant text and click on the tag below to select it. You can use the tags more than once, but you don’t have to use them all if they don’t apply."
  
  getInitialState: ->
    annotation: {}
  
  componentWillMount: ->
    annotation = @props.annotation
    @setState {annotation}
  
  render: ->
    {tools} = tasks[@props.annotation.type]
    <div className="decision-tree-task">
      <div className="decision-tree-question">
        {@instructions}
      </div>
      <ToolList annotation={@state.annotation} tools={tools} addText={@addText} deleteText={@deleteText}>
      </ToolList>
      <div className="decision-tree-confirmation">
        <button type="button" className="major-button" disabled={@invalid()} onClick={@done}>Done</button>
      </div>
    </div>
    
  addText: (e) ->
    textRange = @createSelection e.currentTarget.value
    return unless textRange?
    annotation = @state.annotation
    if textRange.type == 'issue'
      annotation.addIssue textRange
    else
      annotation.addSubtask textRange
    @setState {annotation}
  
  deleteText: (textRange) ->
    return unless textRange?
    annotation = @state.annotation
    if textRange.type == 'issue'
      annotation.deleteIssue textRange
    else
      annotation.deleteSubtask textRange
    @setState {annotation}
    
  done: (e) ->
    @props.onComplete @state.annotation
  
  invalid: ->
    !@state.annotation.issue? && Object.keys(@state.annotation.subtasks).length != 0
  
  createSelection: (type) ->
    sel = document.getSelection()
    if sel.rangeCount
      options =
        type: type
      tool = new SelectionTool options

