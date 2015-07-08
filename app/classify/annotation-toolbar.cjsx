React = require 'react/addons'

module.exports = React.createClass
  displayName: 'AnnotationToolbar'
  
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
    <div className="decision-tree">
      <div className="decision-tree-task" data-task-type="annotation">
        <div className="decision-tree-question">Select text and mark it by clicking a button:</div>
        <div className="decision-tree-choices">
          {@tools.map (tool) =>
            <div className="decision-tree-choice">
              <button className="readymade-choice-clickable" value={tool.value} onClick = {@props.onClick}>
                <span className="readymade-choice-label">{tool.label}</span> 
                <span className="readymade-choice-color #{tool.value}"></span> 
              </button> 
            </div>
          }
        </div> 
      </div>
    </div>