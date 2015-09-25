React = require 'react'
Favourite = require './favourite'
OriginalPage = require './original-page'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  render: ->
    <div className="drawing-controls">
      {<Favourite project={@props.project} api={@props.api} subject={@props.subject} /> if @props.subject? && @props.user?}
      {<OriginalPage subject={@props.subject} /> if @props.subject?}
    </div>