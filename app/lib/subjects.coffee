class Subjects
  queue: []
  api: null
  query:
    workflow_id: 1483 # test workflow on panoptes-staging
    sort: 'queued'
  
  constructor: (@api)->
    @fetch()
  
  current: ->
    @queue[0]
    
  fetch: ->
    @api.type('subjects')
    .get @query
    .then (newSubjects) =>
      @queue.push subject for subject in newSubjects
  
  flush: ->
    subject = null for subject in @queue
    @queue = []
    
  next: ->
    subject = @queue.shift()
    @fetch() if @queue.length < 2
    subject

module.exports = Subjects