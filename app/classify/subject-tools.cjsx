React = require 'react'
Favourite = require './favourite'
CommentsToggle = require './comments-toggle'
OriginalPage = require './original-page'
FieldGuide = require './field-guide'
Tutorial = require './tutorial'
alert = require '../panoptes/alert'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  getInitialState: ->
    fieldGuideHidden: true
  
  render: ->
    <div>
      <div className="drawing-controls">
        <h2>{@props.subject_set.metadata.BOROUGH} {@props.subject_set.metadata.Date} ({@props.subject_set.display_name}) {<span>Page {@props.subject.metadata.page}</span> if @props.subject?}</h2>
        <span className="tools">
          <label className="readymade-has-clickable"> 
            <input type="checkbox" name="examples" checked={!@state.fieldGuideHidden} onChange={@toggleFieldGuide} /> 
            <span className="readymade-clickable"> 
              <span className="fa fa-question"></span>
              <span> Examples</span> 
            </span>
          </label>
          <button className="readymade-clickable" onClick={@showTutorial}>
            <span className="fa fa-graduation-cap"></span>
            &nbsp;Tutorial
          </button>
          {<Favourite project={@props.project} api={@props.api} subject={@props.subject} /> if @props.subject? && @props.user?}
          {<CommentsToggle project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject={@props.subject} /> if @props.subject?}
          {<OriginalPage subject={@props.subject} /> if @props.subject?}
        </span>
      </div>
      <div className="readymade-field-guide-container" aria-hidden={@state.fieldGuideHidden}>
        <FieldGuide api={@props.api} project={@props.project}/>
      </div>
    </div>
  
  toggleFieldGuide: (e) ->
    hidden = @state.fieldGuideHidden
    fieldGuideHidden = !hidden
    @setState {fieldGuideHidden}
  
  showTutorial: (e) ->
    @props.api.type 'tutorials'
      .get
        project_id: @props.project.id
      .then ([tutorial]) =>
        alert (resolve) =>
          <Tutorial tutorial={tutorial} api={@props.api} user={@props.user} project={@props.project} onFinish={resolve} />
