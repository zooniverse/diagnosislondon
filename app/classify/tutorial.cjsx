React = require 'react'
MarkdownIt = require 'markdown-it'

md = new MarkdownIt
  linkify: true
  breaks: true

module.exports = React.createClass
  displayName: 'tutorial'
  
  getInitialState: ->
    tutorial:
      steps: []
    selected: 0
  
  componentWillMount: ->
    @props.api.type 'tutorials'
      .get
        project_id: @props.project.id
      .then ([tutorial]) =>
        @setState {tutorial}
  
  componentDidMount: ->
    @refs.continue.getDOMNode().focus()
  
  render: ->
    if @state.selected == @state.tutorial.steps.length - 1
      label = "Finish"
      action = @props.onFinish
    else
      label = "Continue"
      action = @nextStep
    content = @state.tutorial.steps[@state.selected]?.content ? ''
    <div className="readymade-mini-tutorial-contents">
      <div dangerouslySetInnerHTML={{__html: md.render content}}></div>
      <button ref="continue" className="standard-button" onClick={action}>{label}</button>
    </div>
  
  nextStep: (e) ->
    selected = @state.selected
    selected++
    @setState {selected}
