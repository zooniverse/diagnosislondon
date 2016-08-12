React = require 'react'
SubjectTools = require './subject-tools'
SubjectViewer = require './subject-viewer'

module.exports = React.createClass
  displayName: 'Subject'
  
  getInitialState: ->
    currentSubjects: []
    mode: 'text'
    viewAll: false

  componentWillReceiveProps: (newProps) ->
    {nextSubjectIds, prevSubjectIds} = newProps.subject.metadata
    @props.api.type('subjects')
      .get([nextSubjectIds[0], prevSubjectIds[0]])
      .then (subjects) =>
        @setState 
          currentSubjects: [subjects[1], newProps.subject, subjects[0]]
          mode: 'text'
  
  render: ->
    console.log @props.task
    mode = if @props.task == 'filter' then 'image' else @state.mode
    <div className="readymade-subject-viewer-container">
      {
        if @state.currentSubjects.length
          <div className="readymade-subject-viewer">
            <SubjectTools project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject={@props.subject} />
            {if @props.task isnt 'filter'
              <div style={position: 'relative'}>
                <label className="readymade-clickable image-toggle">
                  <input type="checkbox" onChange={@toggle} />
                  <span className="fa fa-file-text#{if @state.mode is 'image' then '-o' else ' active'}"></span>
                  <span className="fa fa-file-image-o #{if @state.mode is 'image' then 'active' else ''}"></span>
                </label>
              </div>}
            <div className="scroll-container" ref="scrollContainer">
              {<SubjectViewer mode={mode} subject={subject} key={subject.id} active={subject is @props.subject || @state.viewAll} ref="subject#{subject.id}" /> for subject in @state.currentSubjects}
            </div>
          </div>
      }
    </div>
  
  onChange: (annotation) ->
    if annotation.issue
      viewAll = true
    else
      viewAll = false
    @setState {viewAll}
  
  toggle: (e)->
    mode = if @state.mode is 'image' then 'text' else 'image'
    @setState {mode}
