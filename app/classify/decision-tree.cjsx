React = require 'react/addons'

module.exports = React.createClass
  displayName: 'DecisionTree'
  
  render: ->
    <div className="readymade-decision-tree-container">
      <div className="decision-tree">
        <button type="button" name="decision-tree-go-back" disabled="">Back</button>
        <div className="decision-tree-task" data-task-type="radio">
          <div className="decision-tree-question">Are there any health issues on this page?</div>
          <div className="decision-tree-choices">
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper">
                <input type="radio" name="decide" value="yes" data-choice-index="0" /> 
                <div className="readymade-choice-clickable readymade-choice-radio">
                  <div className="readymade-choice-tickbox">
                    <div className="readymade-choice-tick">
                    </div>
                  </div>
                  <div className="readymade-choice-label">Yes</div>
                </div>
              </label>
            </div>
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper">
                <input type="radio" name="decide" value="no" data-choice-index="1" />
                <div className="readymade-choice-clickable readymade-choice-radio">
                  <div className="readymade-choice-tickbox">
                    <div className="readymade-choice-tick"></div>
                  </div>
                  <div className="readymade-choice-label">No</div>
                </div>
              </label>
            </div> 
          </div> 
          <div className="decision-tree-confirmation"> <button type="button" name="decision-tree-confirm-task">OK</button> </div>
        </div>
        <div className="decision-tree-task" data-task-type="annotation" style={display: 'none'}>
          <div className="decision-tree-question">Mark businesses and health issues in the text</div>
          <div className="decision-tree-choices">
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper"> 
                <input type="radio" name="annotate" value="business" checked="checked" data-choice-index="0" /> 
                <div className="readymade-choice-clickable readymade-choice-radio"> 
                  <div className="readymade-choice-tickbox"> 
                    <div className="readymade-choice-tick"></div> 
                  </div>  
                  <div className="readymade-choice-label">Business</div> 
                  <div className="readymade-choice-color"></div> 
                </div> 
              </label>
            </div>
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper"> 
                <input type="radio" name="annotate" value="health" data-choice-index="1" /> 
                <div className="readymade-choice-clickable readymade-choice-radio"> 
                  <div className="readymade-choice-tickbox"> 
                    <div className="readymade-choice-tick"></div> 
                  </div>  
                  <div className="readymade-choice-label">Health issue</div> 
                  <div className="readymade-choice-color"></div> 
                </div> 
              </label>
            </div>
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper"> 
                <input type="radio" name="annotate" value="action" data-choice-index="2" /> 
                <div className="readymade-choice-clickable readymade-choice-radio"> 
                  <div className="readymade-choice-tickbox"> 
                    <div className="readymade-choice-tick"></div> 
                  </div>  
                  <div className="readymade-choice-label">Action taken</div> 
                  <div className="readymade-choice-color"></div> 
                </div> 
              </label>
            </div>
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper"> 
                <input type="radio" name="annotate" value="correction" data-choice-index="3" /> 
                <div className="readymade-choice-clickable readymade-choice-radio"> 
                  <div className="readymade-choice-tickbox"> 
                    <div className="readymade-choice-tick"></div> 
                  </div>  
                  <div className="readymade-choice-label">Correction</div> 
                  <div className="readymade-choice-color"></div> 
                </div> 
              </label>
            </div> 
          </div> 
          <div className="decision-tree-confirmation"> 
            <button type="button" name="decision-tree-confirm-task">OK</button> 
          </div>
        </div>
        <div className="decision-tree-task" data-task-type="button" style={display: 'none'}>
          <div className="decision-tree-question">Use the 'Back' button to review your work, or click 'Finished' to move on to the next page.</div> 
          <div className="decision-tree-choices"> 
            <div className="decision-tree-choice">
              <label className="readymade-choice-input-wrapper"> 
                <input type="button" name="review" value="undefined" data-choice-index="0" /> 
                <div className="readymade-choice-clickable readymade-choice-button"> 
                  <div className="readymade-choice-tickbox"> 
                    <div className="readymade-choice-tick"></div> 
                  </div>  
                  <div className="readymade-choice-label">Finished</div>  
                </div> 
              </label>
            </div> 
          </div> 
          <div className="decision-tree-confirmation" style={display: 'none'}> 
            <button type="button" name="decision-tree-confirm-task">OK</button> 
          </div>
        </div>
      </div>
    </div>