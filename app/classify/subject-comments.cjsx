React = require 'react'

SubjectCommentsForm = React.createClass
  displayName: 'SubjectCommentsForm'
  
  render: ->
    <form method='post' onSubmit={@submitComment}>
      <textarea ref="comment">
      </textarea>
      <button className="major-button" type="submit">
        Add Comment
      </button>
    </form>
  
  submitComment: (e)->
    e.preventDefault()
    commentText = @refs.comment.getDOMNode().value
    
    if @props.discussion?
      user_id = @props.user?.id
      body = commentText
      discussion_id = +@props.discussion.id

      comment = {user_id, discussion_id, body}

      @props.talk.type('comments').create(comment).save()
        .then (comment) =>
          @props.onUpdate comment
          @refs.comment.getDOMNode().value = ''

    else
      @props.talk.type('boards').get({section: "project-#{@props.project.id}", subject_default: true}).index(0)
        .then (board) =>
          focus_id = +@props.subject?.id
          focus_type = 'Subject'
          user_id = @props.user?.id
          body = commentText

          comments = [{user_id, body, focus_id, focus_type}]

          discussion = {
            title: "Subject #{@props.subject.id}"
            user_id: @props.user?.id
            subject_default: true,
            board_id: board.id
            comments: comments
            }
          @props.talk.type('discussions').create(discussion).save()
            .then (discussion) =>
              @props.onUpdate()
              @refs.comment.getDOMNode().value = ''
        .catch (e) ->
          console.log e      

module.exports = React.createClass
  displayName: 'SubjectComments'
  
  render: ->
    <div className="comments">
      <h4>Comments</h4>
      <ul>
        {@props.comments.map (comment) -> <li key={comment.id}>{comment.body}</li>}
      </ul>
      {if @props.user?
        <SubjectCommentsForm talk={@props.talk} project={@props.project} user={@props.user} subject={@props.subject} discussion={@props.discussion} onUpdate={@update} />
      else
        <p>You must be signed in to post comments</p>
      }
    </div>
  
  update: (comment)->
    @props.onChange comment
  
  