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
    @classification?.update
      annotations: annotations
  
  finish: ->
    queue = JSON.parse localStorage.getItem 'classifications'
    queue ?= []
    
    finished = @classification
    
    finished.update
      completed: true
      'metadata.finished_at': (new Date).toISOString()
      'metadata.viewport':
        width: innerWidth
        height: innerHeight
    
    newQueue = []
    for classificationData in queue
      if classificationData?
        @api.type 'classifications'
          .create classificationData
          .save()
          .then (classification) ->
            classification.destroy()
          .catch (e) ->
            newQueue.push classificationData
            localStorage.setItem 'classifications', JSON.stringify newQueue
    
    finished.save()
      .then (classification) ->
        classification.destroy()
      .catch (e) =>
        newQueue.push finished
        localStorage.setItem 'classifications', JSON.stringify newQueue
    localStorage.setItem 'classifications', JSON.stringify newQueue


module.exports = Classifications