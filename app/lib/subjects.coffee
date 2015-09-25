class Subjects
  queue: []
  api: null
  query:
    sort: 'queued'
    subject_set_id: "1890"
    page_size: "30"
  
  constructor: (@api, @project)->
    @query.workflow_id = @project?.links.workflows[0]
  
  update: (opts) ->
    @[opt] = value for opt, value of opts
    
  current: ->
    @queue[0]
    
  fetch: ->
    return Promise.resolve [] unless @query.workflow_id?
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