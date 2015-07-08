React = require 'react/addons'

module.exports = React.createClass
  displayName: 'DecisionTree'
  
  render: ->
    <div className="decision-tree">
      <div className="decision-tree-task" data-task-type="annotation">
        <div className="decision-tree-question">Mark businesses and health issues in the text</div>
        <div className="decision-tree-choices">
          <div className="decision-tree-choice">
            <label className="readymade-choice-input-wrapper"> 
              <input type="radio" name="annotate" value="business" onChange = {@props.onChange} /> 
              <div className="readymade-choice-clickable readymade-choice-radio"> 
                <div className="readymade-choice-tickbox"> 
                  <div className="readymade-choice-tick"></div> 
                </div>  
                <div className="readymade-choice-label">Business</div> 
                <div className="readymade-choice-color business"></div> 
              </div> 
            </label>
          </div>
          <div className="decision-tree-choice">
            <label className="readymade-choice-input-wrapper"> 
              <input type="radio" name="annotate" value="health" onChange = {@props.onChange} /> 
              <div className="readymade-choice-clickable readymade-choice-radio"> 
                <div className="readymade-choice-tickbox"> 
                  <div className="readymade-choice-tick"></div> 
                </div>  
                <div className="readymade-choice-label">Health issue</div> 
                <div className="readymade-choice-color health"></div> 
              </div> 
            </label>
          </div>
          <div className="decision-tree-choice">
            <label className="readymade-choice-input-wrapper"> 
              <input type="radio" name="annotate" value="action" onChange = {@props.onChange} /> 
              <div className="readymade-choice-clickable readymade-choice-radio"> 
                <div className="readymade-choice-tickbox"> 
                  <div className="readymade-choice-tick"></div> 
                </div>  
                <div className="readymade-choice-label">Action taken</div> 
                <div className="readymade-choice-color action"></div> 
              </div> 
            </label>
          </div> 
        </div> 
      </div>
    </div>