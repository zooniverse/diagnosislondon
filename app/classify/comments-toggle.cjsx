React = require 'react'
SubjectComments = require './subject-comments'

module.exports = React.createClass
  displayName: 'CommentsToggle'
  
  getInitialState: ->
    active: false
    comments: []
    discussion: null
  
  componentDidMount: ->
    @loadComments @props.subject?.id
  
  componentWillReceiveProps: (newProps) ->
    @loadComments newProps.subject?.id unless newProps.subject == @props.subject
  
  render: ->
    <div style={display: 'inline-block', position: 'relative'}>
      <label className="readymade-has-clickable"> 
        <input type="checkbox" name="comments" checked={@state.active} onChange={@toggleComments} /> 
        <span className="readymade-clickable"> 
          <span className="fa fa-comments#{if @state.active then '' else '-o'}"></span>
          <span> Show Comments</span> 
        </span> 
      </label>
      {<SubjectComments project={@props.project} user={@props.user} subject={@props.subject} talk={@props.talk} discussion={@state.discussion} comments={@state.comments} onChange={@update} /> if @props.subject? && @state.active}
    </div>
      
  toggleComments: (e)->
    @setState active: !@state.active
  
  loadComments: (subject_id) ->
    @props.talk.type('discussions')
      .get({focus_id: subject_id, focus_type: 'Subject'})
      .then ([discussion]) =>
        if discussion?
          @props.talk.type('comments')
            .get({discussion_id: discussion.id})
            .then (comments) =>
              console.log comments
              @setState {discussion, comments}
        else
          @setState {discussion: null, comments: []}
      .catch (e) =>
        console.log e
        @setState {discussion: null, comments: []}
  
  update: (comment)->
    if comment?
      comments = @state.comments
      comments.push comment
      @setState {comments}
    else
      @loadComments @props.subject.id