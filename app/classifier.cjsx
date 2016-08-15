React = require 'react'

Annotation = require './classify/annotation'
ClassificationTask = require './classify/classification-task'
Subject = require './classify/subject'
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
    @subjects.update {api, project, subject_set_id: subject_set?.id}
    @classifications.update {api, project, workflow}
    
    if newProps.user != @props.user 
      @setState currentSubjects: [], =>
        @subjects.flush()
        @subjects.fetch()
          .then @nextSubject
      
  render: ->
    <ClassificationTask onChange={@onChangeAnnotation} onFinish={@onFinishPage}>
      <Subject ref='subject' project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@state.currentSubjects[0]} />
    </ClassificationTask>
  
  onChangeAnnotation: (annotation) ->
    @refs.subject.onChange annotation

  onFinishPage: (task_annotations) ->
    @classifications?.set_annotations ({task: key, value: value} for key, value of task_annotations)
    # @classifications.finish()
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

