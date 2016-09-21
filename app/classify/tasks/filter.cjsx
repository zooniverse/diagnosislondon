React = require 'react'

answers =
  yes:
    label: 'Yes'
    value: 'yes'
  no:
    label: 'No'
    value: 'no'

module.exports = React.createClass
  displayName: 'FilterTask'
  
  getDefaultProps: ->
    name: 'filter'
    
  getInitialState: ->
    value: null
  
  render: ->
    label = 'Next'
    label = 'Finish' if @state.value is 'no'
    <div className="decision-tree-task">
      <div className="decision-tree-question">
        Are there any health issues to mark on this page?
      </div>
      <div className="decision-tree-choices">
        {for key, answer of answers
          <label key={key} className="decision-tree-choice">
            <input type="radio" name={@props.name} value={answer.value} checked={@state.value is answer.value} onChange={@choose} />
            <span className="readymade-choice-clickable standard-button">{answer.label}</span>
          </label> 
        }
        {@props.children}
        <button type="button" className="major-button" onClick={@complete} disabled={!@state.value}>{label}</button>
      </div>
    </div>
  
  choose: (e) ->
    @setState value: e.currentTarget.value
  
  complete: ->
    @props.onComplete @state.value
    @setState value: null

