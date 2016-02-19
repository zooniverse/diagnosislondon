React = require 'react'

BOROUGHS = [
  'Battersea'
  'Bermondsey'
  'Camberwell'
]

module.exports = React.createClass
  displayName: 'ChooseSubjectSet'
  
  getInitialState: ->
    subject_sets: []
    borough: 'Battersea'
    
  componentWillMount: ->
    @loadSubjectSets(@state.borough)
        
  
  render: ->
    <div className="reports">
      <h2>Choose a report to work on</h2>
      <ul role="tabList">
        {<li key=borough  role="presentation"><label><input name="borough" type="radio" checked={@state.borough is borough} role="tab" aria-selected={@state.borough is borough} onChange={@selectBorough} value={borough}/><span>{borough}</span></label></li> for borough in BOROUGHS}
      </ul>
      <ul>
        {<li key="set-#{subject_set.id}"><a onClick={@update} href="#/classify/#{subject_set.id}">{subject_set.metadata.BOROUGH.replace(' (London, England)', '')}<br/>{subject_set.metadata.Date}</a></li> for subject_set in @state.subject_sets}
      </ul>
    </div>
  
  selectBorough: (e) ->
    borough = e.target.value
    @setState {borough}
    @loadSubjectSets(borough)
  
  loadSubjectSets: (borough) ->
    @props.workflow?.get 'subject_sets', {page_size: 40, "metadata.BOROUGH": borough + ' (London, England)'}
      .then (subject_sets) =>
        subject_sets.sort (a, b) ->
          return 1 if a.metadata.BOROUGH > b.metadata.BOROUGH
          return -1 if a.metadata.BOROUGH < b.metadata.BOROUGH
          return 1 if a.metadata['File prefix'] > b.metadata['File prefix']
          return -1 if a.metadata['File prefix'] < b.metadata['File prefix']
          return 0
        @setState {subject_sets}
  
  update: (e) ->
    subject_set_id = e.currentTarget.href.split('/').pop()
    @props.onChange subject_set_id