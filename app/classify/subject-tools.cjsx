React = require 'react'
Favourite = require './favourite'
CommentsToggle = require './comments-toggle'
OriginalPage = require './original-page'
FieldGuide = require './field-guide'
alert = require '../panoptes/alert'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  render: ->
    <div className="drawing-controls">
      <h2>{@props.subject_set.metadata.BOROUGH} {@props.subject_set.metadata.Date} ({@props.subject_set.display_name})</h2>
      <span className="tools">
        <label className="readymade-has-clickable"> 
          <button className="readymade-clickable" onClick={@showFieldGuide}> 
            <span className="fa fa-question"></span>
            <span>Examples</span> 
          </button> 
        </label>
        {<Favourite project={@props.project} api={@props.api} subject={@props.subject} /> if @props.subject? && @props.user?}
        {<CommentsToggle project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject={@props.subject} /> if @props.subject?}
        {<OriginalPage subject={@props.subject} /> if @props.subject?}
      </span>
    </div>
  
  showFieldGuide: (e) ->
    alert (resolve) =>		
     <FieldGuide api={@props.api} project={@props.project}/>
