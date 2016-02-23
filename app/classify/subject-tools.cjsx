React = require 'react'
Favourite = require './favourite'
CommentsToggle = require './comments-toggle'
OriginalPage = require './original-page'
FieldGuide = require './field-guide'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  render: ->
    <div className="drawing-controls">
      <h2>{@props.subject_set.metadata.BOROUGH} {@props.subject_set.metadata.Date} ({@props.subject_set.display_name})</h2>
      <span className="tools">
        {<Favourite project={@props.project} api={@props.api} subject={@props.subject} /> if @props.subject? && @props.user?}
        {<CommentsToggle project={@props.project} api={@props.api} talk={@props.talk} user={@props.user} subject={@props.subject} /> if @props.subject?}
        {<OriginalPage subject={@props.subject} /> if @props.subject?}
      </span>
      <FieldGuide api={@props.api} project={@props.project}/>
    </div>
