React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'
Subjects = require './lib/subjects'
Classifications = require './lib/classifications'

module.exports = React.createClass
  displayName: 'Classifier'
  
  subjects: null
  classifications: null
  
  getInitialState: ->
    annotations: []
    currentSubject: null
  
  componentWillMount: ->
    @subjects = new Subjects @props.api
    @classifications = new Classifications @props.api
  
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
          <SubjectTools api={@props.api} subject={@state.currentSubject} />
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
    @classifications?.set_annotations ({task: key, value: value} for key, value of tasks)
    
  onToolbarClick: (e) ->
    @addText @refs.subject_viewer.createAnnotation e.currentTarget.value
  
  onFinishPage: ->
    @classifications.finish()
    console.log JSON.stringify @classifications.current()
    console.log @state.currentSubject?.metadata.image
    @classifications.current().save()
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
    @classifications.create currentSubject if currentSubject?
    @setState {currentSubject}

  reset: ->
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    @setState {annotations}