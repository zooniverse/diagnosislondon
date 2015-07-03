React = require 'react/addons'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
DecisionTree = require './classify/decision-tree'
ClassificationSummary = require './classify/summary'

module.exports = React.createClass
  displayName: 'Classifier'

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer />
        </div>
      </div> 
      <DecisionTree /> 
      <ClassificationSummary />
    </div> 