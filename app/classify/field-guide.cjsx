React = require 'react'
MarkdownIt = require 'markdown-it'

md = new MarkdownIt
  linkify: true
  breaks: true

module.exports = React.createClass
  displayName: 'FieldGuide'
  
  getInitialState: ->
    fieldGuide:
      items: []
    selected: 0
  
  componentWillMount: ->
    @props.api.type 'field_guides'
      .get
        project_id: @props.project.id
      .then ([fieldGuide]) =>
        @setState {fieldGuide}
  
  render: ->
    content = @state.fieldGuide.items[@state.selected]?.content ? ''
    <div ref="container" tabIndex="-1" className="readymade-field-guide">
      <div className="readymade-field-guide-tabs" role="tabList">
        {for item, i in @state.fieldGuide.items
          <label key="fg-tab-#{i}">
            <input name="fgtab" type="radio" checked={i is @state.selected} role="tab" aria-selected={i is @state.selected} value=i onChange={@selectTab}/>
            <span>{item.title}</span>
          </label>
        }
      </div>
      <div className="readymade-field-guide-page">
        <div dangerouslySetInnerHTML={{__html: md.render content}}></div>
      </div>
    </div>
  
  selectTab: (e) ->
    selected = parseInt e.currentTarget.value
    @setState {selected}