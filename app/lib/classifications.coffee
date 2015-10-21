class Classifications
  api: null
  project: null
  classification: null
  workflow: null
  
  constructor: (@api, @project, @workflow)->
    
  current: ->
    @classification
  
  update: (opts) ->
    @[opt] = value for opt, value of opts
    
  create: (subjects)->
    @classification = @api
      .type('classifications')
      .create
        annotations: []
        metadata:
          workflow_version: @workflow?.version
          started_at: (new Date).toISOString()
          user_agent: navigator.userAgent
          user_language: navigator.language
          utc_offset: ((new Date).getTimezoneOffset() * 60).toString() # In seconds
        links:
          project: @project?.id.toString()
          workflow: @workflow?.id
          subjects: (subject.id for subject in subjects)
  
  set_annotations: (annotations) ->
    @classification?.annotations = annotations
  
  finish: ->
    @classification.update
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight

module.exports = Classifications