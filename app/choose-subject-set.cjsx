React = require 'react'

module.exports = React.createClass
  displayName: 'ChooseSubjectSet'
  
  getInitialState: ->
    subject_sets: []
    
  componentWillMount: ->
    @props.workflow?.get 'subject_sets', page_size: 40
      .then (subject_sets) =>
        subject_sets.sort (a, b) ->
          return 1 if a.metadata.BOROUGH > b.metadata.BOROUGH
          return -1 if a.metadata.BOROUGH < b.metadata.BOROUGH
          return 1 if a.metadata['File prefix'] > b.metadata['File prefix']
          return -1 if a.metadata['File prefix'] < b.metadata['File prefix']
          return 0
        @setState {subject_sets}
  
  render: ->
    <div className="reports">
      <h2>Choose a report to work on</h2>
      <ul>
        {<li key="set-#{subject_set.id}"><a onClick={@update} href="#/classify/#{subject_set.id}">{subject_set.metadata.BOROUGH.replace(' (London, England)', '')}<br/>{subject_set.metadata.Date}</a></li> for subject_set in @state.subject_sets}
      </ul>
    </div>
  
  update: (e) ->
    subject_set_id = e.currentTarget.href.split('/').pop()
    @props.onChange subject_set_id