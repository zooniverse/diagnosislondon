React = require 'react'
SubjectTools = require './subject-tools'
SubjectViewer = require './subject-viewer'

module.exports = React.createClass
  displayName: 'Subject'
  
  render: ->
    console.log @props.task 
    <div className="readymade-subject-viewer-container">
      {
        if @props.currentSubjects.length
          <div className="readymade-subject-viewer">
            <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject_set={@props.subject_set} subject={@props.currentSubjects[0]} />
            <div className="scroll-container" ref="scrollContainer">
              {<SubjectViewer task={@props.task} subject={subject} key={subject.id} ref="subject#{subject.id}" /> for subject in @props.currentSubjects}
            </div>
          </div>
      }
    </div>