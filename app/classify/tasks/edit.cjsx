React = require 'react/addons'

module.exports = React.createClass
  displayName: 'EditTask'
  
  tools: [{
    label: 'Business'
    value: 'business'
  },{
    label: 'Health issue'
    value: 'health'
  },{
    label: 'Action taken'
    value: 'action'
  }]
  
  render: ->
    <div className="decision-tree-task">
      <div className="decision-tree-question">Select text and mark it by clicking a button:</div>
      <div className="decision-tree-choices">
        {@tools.map (tool) =>
          <div key={tool.value} className="decision-tree-choice">
            <button className="readymade-choice-clickable" value={tool.value} onClick={@selectText}>
              <span className="readymade-choice-label">{tool.label}</span> 
              <span className="readymade-choice-color #{tool.value}"></span> 
            </button> 
          </div>
        }
      </div>
      <div className="decision-tree-confirmation">
        <button type="button" name="decision-tree-confirm-task" onClick={@done}>Done</button>
      </div>
    </div>
  
  selectText: (e) ->
    @props.onClick e
    
  done: (e) ->
    @props.onComplete()