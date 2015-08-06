React = require 'react'
MarkdownIt = require 'markdown-it'

md = new MarkdownIt
  linkify: true
  breaks: true

module.exports = React.createClass
  displayName: 'PanoptesPage'
  
  getDefaultProps: ->
    project: null
    url_key: null
  
  getInitialState: ->
    content: ''
  
  componentWillMount: ->
    @props.project.get('pages', url_key: @props.url_key).index(0)
      .then @update
  
  render: ->
    <div className="column" dangerouslySetInnerHTML={{__html: md.render @state.content}} />
  
  update: (page) ->
    content = page?.content
    content ?= 'No page content yet.'
    @setState {content}
