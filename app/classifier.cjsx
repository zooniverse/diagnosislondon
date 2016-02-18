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
  
  componentDidUpdate: ->
    container = @refs.scrollContainer.getDOMNode()
    subject_node = @refs["subject#{@subjects.current.id}"].getDOMNode()
    distance = subject_node.offsetTop / 20
    
    move_subject = =>
      container.scrollTop = container.scrollTop + distance
      setTimeout move_subject, 50 unless container.scrollTop > subject_node.offsetTop - 50
    
    container.scrollTop -= subject_node.scrollHeight
    setTimeout move_subject, 50
      
  render: ->
    <ClassificationTask onFinish={@onFinishPage}>
      <div className="readymade-subject-viewer-container">
        {
          if @state.currentSubjects.length
            <div className="readymade-subject-viewer">
              <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@state.currentSubjects[0]} />
              <div className="scroll-container" ref="scrollContainer">
                {<SubjectViewer subject={subject} key={subject.id} ref="subject#{subject.id}" /> for subject in @state.currentSubjects}
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
    currentSubjects = @state.currentSubjects
    if currentSubjects.length is 0
      currentSubjects.push @subjects.next(), @subjects.queue[0]
    else
      @subjects.next()
      currentSubjects.push @subjects.queue[0]
      currentSubjects.shift() if currentSubjects.length > 3
    # create a new classification here
    @classifications.create [@subjects.current]
    @setState {currentSubjects}

