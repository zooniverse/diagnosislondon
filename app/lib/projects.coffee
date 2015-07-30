class Projects
  project: null
  api: null
  query:
    display_name: 'Diagnosis London'
  
  constructor: (@api)->
  
  current: ->
    @project
    
  fetch: ->
    @api.type('projects')
    .get @query
    .then ([project]) =>
      @project = project

module.exports = Projects