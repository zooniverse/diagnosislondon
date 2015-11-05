React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'
SelectionTool = require './lib/selection-tool'
Subjects = require './lib/subjects'
Classifications = require './lib/classifications'
{tasks} = require './config'

module.exports = React.createClass
  displayName: 'Classifier'
  
  subjects: null
  classifications: null
  
  getInitialState: ->
    annotations: []
    currentSubjects: []
  
  componentWillMount: ->
    @subjects = new Subjects @props.api, @props.project, @props.subject_set?.id
    @classifications = new Classifications @props.api, @props.project, @props.workflow
    @subjects.fetch()
    .then @nextSubject
  
  componentWillReceiveProps: (newProps)->
    {api, project, subject_set, workflow} = newProps
    @subjects.update {api, project, subject_set_id: subject_set.id}
    @classifications.update {api, project, workflow}
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
        {
          if @state.currentSubjects.length
            <div className="readymade-subject-viewer">
              <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@state.currentSubjects[0]} />
              <div className="scroll-container">
                {<SubjectViewer subject={subject} key={subject.id} /> for subject in @state.currentSubjects}
              </div>
            </div>
        }
      </div>
    </div>
  
  componentDidUpdate: ->
    #update classifications here
    annotations = []
    task_annotations = {}
    @state.annotations.map (annotation, i) ->
      task_annotations[annotation.type] ?= []
      for type of annotation.ranges
        task_annotations[annotation.type].push (annotation.ranges[type].map (range) -> range.annotation)
    task_annotations[task] ?= [] for task of tasks
    @classifications?.set_annotations ({task: key, value: value} for key, value of task_annotations)
    
  onToolbarClick: (e) ->
    @addText @createSelection e.currentTarget.value
  
  onFinishPage: ->
    @classifications.finish()
    console.log JSON.stringify @classifications.current()
    console.log @state.currentSubjects[0]?.metadata.image
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
    currentSubjects = [@subjects.next(), @subjects.queue[0]]
    # create a new classification here
    @classifications.create currentSubjects if currentSubjects.length
    @setState {currentSubjects}

  reset: ->
    annotations = @state.annotations
    annotation.destroy() for annotation in annotations
    annotations = []
    currentSubjects = []
    @setState {annotations, currentSubjects}
  
  createSelection: (type) ->
    sel = document.getSelection()
    if sel.rangeCount
      options =
        type: type
      tool = new SelectionTool options