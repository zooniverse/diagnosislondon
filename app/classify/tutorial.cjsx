React = require 'react'
MarkdownIt = require 'markdown-it'

md = new MarkdownIt
  linkify: true
  breaks: true
  
completedThisSession = false

module.exports = React.createClass
  displayName: 'tutorial'
  
  statics:
    checkIfCompleted: (user, project) ->
      getCompletedAt = if user?
        user.get 'project_preferences', project_id: project.id
          .catch =>
            []
          .then ([projectPreferences]) =>
            new Date projectPreferences?.preferences?.tutorial_completed_at
      else
        Promise.resolve null

      getCompletedAt.then (completedAt) =>
        if isNaN completedAt?.valueOf()
          completedThisSession
        else
          # TODO: Check if the completion date is greater than the tutorial's modified_at date.
          # Return `null` to mean "Completed, but not with the most recent version".
          true
  
  getInitialState: ->
    selected: 0
  
  componentDidMount: ->
    @refs.continue.getDOMNode().focus()
  
  render: ->
    if @state.selected == @props.tutorial.steps.length - 1
      label = "Finish"
      action = @onFinish
    else
      label = "Continue"
      action = @nextStep
    content = @props.tutorial.steps[@state.selected]?.content ? ''
    <div className="readymade-mini-tutorial-contents">
      <div dangerouslySetInnerHTML={{__html: md.render content}}></div>
      <button ref="continue" className="standard-button" onClick={action}>{label}</button>
    </div>
  
  nextStep: (e) ->
    selected = @state.selected
    selected++
    @setState {selected}
  
  onFinish: ->
    @props.onFinish()
    completedThisSession = true
    @props.user?.get('project_preferences', project_id: @props.project.id)
      .then ([projectPreferences]) =>
        projectPreferences ?= @props.api.type('project_preferences').create({
          links: {
            project: @props.project.id
          },
          preferences: {}
        })
        projectPreferences.update 'preferences.tutorial_completed_at': new Date().toISOString()
        projectPreferences.save()
