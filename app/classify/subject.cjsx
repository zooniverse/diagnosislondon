React = require 'react'
SubjectTools = require './subject-tools'
SubjectViewer = require './subject-viewer'

module.exports = React.createClass
  displayName: 'Subject'
  
  getInitialState: ->
    currentSubjects: []

  componentWillReceiveProps: (newProps) ->
    {nextSubjectIds, prevSubjectIds} = newProps.subject.metadata
    @props.api.type('subjects')
      .get([nextSubjectIds[0], prevSubjectIds[0]])
      .then (subjects) =>
        @setState currentSubjects: [subjects[1], newProps.subject, subjects[0]]
  
  render: ->
    console.log @props.task 
    <div className="readymade-subject-viewer-container">
      {
        if @state.currentSubjects.length
          <div className="readymade-subject-viewer">
            <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@props.subject} />
            <div className="scroll-container" ref="scrollContainer">
              {<SubjectViewer task={@props.task} subject={subject} key={subject.id} active={subject is @props.subject} ref="subject#{subject.id}" /> for subject in @state.currentSubjects}
            </div>
          </div>
      }
    </div>
  
  onChange: (annotation) ->
    if annotation.issue
      @refs["subject#{subject.id}"].getDOMNode().classList.add 'active' for subject in @state.currentSubjects
    else
      @refs["subject#{subject.id}"].getDOMNode().classList.remove 'active' for subject in @state.currentSubjects
      @refs["subject#{@props.subject.id}"].getDOMNode().classList.add 'active'
