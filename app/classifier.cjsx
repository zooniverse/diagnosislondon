React = require 'react/addons'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
DecisionTree = require './classify/decision-tree'
ClassificationSummary = require './classify/summary'

module.exports = React.createClass
  displayName: 'Classifier'
  
  tools: []
  
  getInitialState: ->
    value: 'business'

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer ref='subject_viewer' value = {@state.value} addTool = {@addTool} />
        </div>
      </div> 
      <DecisionTree onChange = {@onDecisionTreeChange} /> 
      <ClassificationSummary />
    </div>
    
  onDecisionTreeChange: (e) ->
    @setState value: e.target.value
  
  addTool: (tool) ->
    @tools.push tool if tool?

  deleteTool: (tool) ->
  
    index = @tools.indexOf tool
    @tools.splice index, 1

  load: (text) ->
    @reset()
    @el.innerHTML = text

  reset: ->
      @tools[0].destroy() until @tools.length is 0