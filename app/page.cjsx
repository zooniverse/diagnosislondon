React = require 'react'
{Markdown} = require 'markdownz'

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
    console.log @state
    <Markdown className="column">
      {@state.content}
    </Markdown>
  
  update: (page) ->
    content = page?.content
    content ?= 'No page content yet.'
    @setState {content}
