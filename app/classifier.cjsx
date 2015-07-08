React = require 'react/addons'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
AnnotationTool = require './classify/annotation-tool'
DecisionTree = require './classify/decision-tree'
ClassificationSummary = require './classify/summary'

module.exports = React.createClass
  displayName: 'Classifier'
  
  getInitialState: ->
    value: 'business'
    tools: []

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer ref='subject_viewer' value = {@state.value} addTool = {@addTool} />
        </div>
      </div>
      <div className="readymade-decision-tree-container">
        {@state.tools.map (tool, i) =>
          <AnnotationTool key={tool.id} tool={tool} deleteTool = {@deleteTool} />
        }
        <DecisionTree onChange = {@onDecisionTreeChange} /> 
        <ClassificationSummary />
      </div>
    </div>
    
  onDecisionTreeChange: (e) ->
    @setState value: e.target.value
  
  addTool: (tool) ->
    tools = @state.tools
    tools.push tool if tool?
    @setState {tools}

  deleteTool: (tool) ->
    tools = @state.tools
    index = tools.indexOf tool
    tools.splice index, 1
    tool.destroy()
    @setState {tools}

  load: (subject) ->
    @reset()

  reset: ->
    tools = @state.tools
    tools[0].destroy() until @tools.length is 0
    @setState {tools}