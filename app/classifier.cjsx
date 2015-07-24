React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'
Subjects = require './lib/subjects'

module.exports = React.createClass
  displayName: 'Classifier'
  
  subjects: null
  classification:
    annotations: []
  
  getInitialState: ->
    annotations: []
    currentSubject: null
  
  componentWillMount: ->
    @subjects = new Subjects @props.api
  
  componentWillReceiveProps: (newProps)->
    @reset()
    @subjects.flush()
    @subjects.fetch()
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
    @classification.update
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight
    console.log JSON.stringify @classification
    console.log @state.currentSubject?.metadata.image
    @classification.save()
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
    
  nextSubject: ->
    currentSubject = @subjects.next()
    # create a new classification here
    @classification = @createClassification currentSubject if currentSubject?
    @setState {currentSubject}
  
  createClassification: (subject)->
    classification = @props.api
      .type('classifications')
      .create
        annotations: []
        metadata:
          workflow_version: "1.1"
          started_at: (new Date).toISOString()
          user_agent: navigator.userAgent
          user_language: navigator.language
          utc_offset: ((new Date).getTimezoneOffset() * 60).toString() # In seconds
        links:
          project: "908"
          workflow: "1483"
          subjects: [subject.id]

  reset: ->
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    @setState {annotations}