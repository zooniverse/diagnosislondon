React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'

module.exports = React.createClass
  displayName: 'Classifier'
  
  getInitialState: ->
    annotations: []
  
  getDefaultProps: ->
    subjects: []

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-decision-tree-container">
        <AnnotationToolbar annotations={@state.annotations} onClick={@onToolbarClick} addTool={@newAnnotation} deleteTool={@deleteAnnotation} onFinish={@onFinishPage} />
        <ClassificationSummary />
      </div>
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer subject={@props.subjects[0]} ref='subject_viewer' />
        </div>
      </div>
    </div>
    
  onToolbarClick: (e) ->
    @addText @refs.subject_viewer.createAnnotation e.currentTarget.value
  
  onFinishPage: ->
    console.log @state.annotations
    @reset()
    @props.subjects.shift()
  
  newAnnotation: (type) ->
    annotations = @state.annotations
    annotations.unshift new AnnotationTool type
    @setState {annotations}
    
  addText: (textRange) ->
    annotations = @state.annotations
    currentAnnotation = annotations.shift()
    currentAnnotation.addRange textRange if textRange?
    annotations.unshift currentAnnotation
    @setState {annotations}

  deleteAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    annotation.destroy()
    @setState {annotations}

  load: (subject) ->
    @reset()

  reset: ->
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    @setState {annotations}