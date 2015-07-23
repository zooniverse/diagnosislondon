React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'

module.exports = React.createClass
  displayName: 'Classifier'
  
  subjectQuery:
    workflow_id: 1483 # test workflow on panoptes-staging
    sort: 'queued'
  
  subjects: []
  classification:
    annotations: []
  
  getInitialState: ->
    annotations: []
    currentSubject: null
  
  componentWillReceiveProps: (newProps)->
    @reset()
    @subjects = []
    @fetchSubjects()
    .then @nextSubject

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-decision-tree-container">
        <AnnotationToolbar annotations={@state.annotations} onClick={@onToolbarClick} addTool={@newAnnotation} deleteTool={@deleteAnnotation} onFinish={@onFinishPage} />
        <ClassificationSummary />
      </div>
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer subject={@state.currentSubject} ref='subject_viewer' />
        </div>
      </div>
    </div>
  
  componentDidUpdate: ->
    #update classifications here
    annotations = []
    tasks = {}
    @state.annotations.map (annotation, i) ->
      tasks[annotation.type] ?= []
      tasks[annotation.type].push (range.annotation for range in annotation.ranges)
    @classification.annotations = ({task: key, value: value} for key, value of tasks)
    
  onToolbarClick: (e) ->
    @addText @refs.subject_viewer.createAnnotation e.currentTarget.value
  
  onFinishPage: ->
    console.log JSON.stringify @classification
    console.log @state.currentSubject?.metadata.image
    @reset()
    @nextSubject()
  
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

  fetchSubjects: ->
    @props.api.type('subjects')
    .get @subjectQuery
    .then (newSubjects) =>
      @subjects.push subject for subject in newSubjects
    
  nextSubject: ->
    currentSubject = @subjects.shift()
    # create a new classification here
    @classification = @createClassification currentSubject
    @fetchSubjects() if @subjects.length < 2
    @setState {currentSubject}
  
  createClassification: (subject)->
    classification = @props.api
      .type('classification')
      .create
        annotations: []
        metadata:
          workflow_version: 1.1
          started_at: (new Date).toISOString()
          user_agent: navigator.userAgent
          user_language: navigator.language
          utc_offset: ((new Date).getTimezoneOffset() * 60).toString() # In seconds
          subject_dimensions: (null for location in subject.locations)
        links:
          project: 908
          workflow: 1483
          subjects: [subject.id]

  reset: ->
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    @setState {annotations}