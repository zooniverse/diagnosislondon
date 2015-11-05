React = require 'react'
alert = require '../../panoptes/alert'
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
    @setState ranges: @props.annotation.ranges
  
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
      <h3>{tasks[@props.annotation.type].label}</h3>
      <p>{tasks[@props.annotation.type].description}</p>
      <div className="decision-tree-question">
        To collect all the information about this health issue, highlight a piece of relevant text and click on the tag below to select it. You can use the tags more than once, but you don't have to use them all if they don’t apply.
      </div>
      <ToolList annotation={@props.annotation} tools={tools} onClick={@props.onClick}>
      </ToolList>
      <div className="decision-tree-confirmation">
        <button type="button" className="major-button" onClick={@done}>Done</button>
      </div>
    </div>
    
  done: (e) ->
    @props.onComplete()
