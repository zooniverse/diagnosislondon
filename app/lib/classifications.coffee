class Classifications
  api: null
  project: null
  classification: null
  
  constructor: (@api, @project)->
    @project?.get 'workflows'
      .then ([workflow]) =>
        @workflow = workflow
    
  current: ->
    @classification
    
  create: (subject)->
    @classification = @api
      .type('classifications')
      .create
        annotations: []
        metadata:
          workflow_version: "1.1"
          started_at: (new Date).toISOString()
          user_agent: navigator.userAgent
          user_language: navigator.language
          utc_offset: ((new Date).getTimezoneOffset() * 60).toString() # In seconds
        links:
          project: @project?.id.toString()
          workflow: @project?.links.workflows[0]
          subjects: [subject.id]
  
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