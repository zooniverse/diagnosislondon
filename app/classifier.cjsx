React = require 'react'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
ClassificationTask = require './classify/classification-task'
Subjects = require './lib/subjects'
Classifications = require './lib/classifications'

module.exports = React.createClass
  displayName: 'Classifier'
  
  subjects: null
  classifications: null
  
  getInitialState: ->
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
    
    if newProps.user != @props.user || newProps.subject_set.id != @props.subject_set.id
      @setState currentSubjects: [], =>
        @subjects.flush()
        @subjects.fetch()
          .then @nextSubject
      
  render: ->
    <ClassificationTask onChange={@onChangeAnnotation} onFinish={@onFinishPage}>
      <div className="readymade-subject-viewer-container">
        {
          if @state.currentSubjects.length
            <div className="readymade-subject-viewer">
              <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@state.currentSubjects[0]} />
              <div className="scroll-container" ref="scrollContainer">
                {<SubjectViewer subject={subject} key={subject.id} ref="subject#{subject.id}" isCurrent={subject.id is @subjects.current.id} /> for subject in @state.currentSubjects}
              </div>
            </div>
        }
      </div>
    </ClassificationTask>
  
  onChangeAnnotation: (annotation) ->
    if annotation.issue
      @refs["subject#{subject.id}"].getDOMNode().classList.add 'active' for subject in @state.currentSubjects
    else
      @refs["subject#{subject.id}"].getDOMNode().classList.remove 'active' for subject in @state.currentSubjects

  onFinishPage: (task_annotations) ->
    @classifications?.set_annotations ({task: key, value: value} for key, value of task_annotations)
    @classifications.finish()
    console.log JSON.stringify @classifications.current()
    console.log @state.currentSubjects[0]?.metadata.image
    @nextSubject()
    
  nextSubject: ->
    currentSubjects = [@subjects.next()]
    # create a new classification here
    @classifications.create [@subjects.current]
    # remove undefined or null subjects from currentSubjects
    currentSubjects = currentSubjects.filter Boolean
    @setState {currentSubjects}

