React = require 'react'

module.exports = React.createClass
  displayName: 'ChooseSubjectSet'
  
  getInitialState: ->
    subject_sets: []
    
  componentWillMount: ->
    @props.workflow.get 'subject_sets'
      .then (subject_sets) =>
        @setState {subject_sets}
  
  render: ->
    <div>
      <h2>Choose a report to work on</h2>
      <ul>
        {<li key="set-#{subject_set.id}"><a onClick={@update} href="#/classify/#{subject_set.id}">{subject_set.display_name}</a></li> for subject_set in @state.subject_sets}
      </ul>
    </div>
  
  update: (e) ->
    subject_set_id = e.currentTarget.href.split('/').pop()
    @props.onChange subject_set_id