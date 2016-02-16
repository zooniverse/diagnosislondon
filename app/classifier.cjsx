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
    @subjects.flush()
    @subjects.fetch()
    .then @nextSubject

  render: ->
    <ClassificationTask onFinish={@onFinishPage}>
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
    </ClassificationTask>
  
  onFinishPage: (task_annotations) ->
    @classifications?.set_annotations ({task: key, value: value} for key, value of task_annotations)
    @classifications.finish()
    console.log JSON.stringify @classifications.current()
    console.log @state.currentSubjects[0]?.metadata.image
    @nextSubject()
    
  nextSubject: ->
    currentSubjects = [@subjects.next(), @subjects.queue[0]]
    # create a new classification here
    @classifications.create currentSubjects if currentSubjects.length
    @setState {currentSubjects}

