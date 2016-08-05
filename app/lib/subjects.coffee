class Subjects
  queue: []
  api: null
  current: null
  query:
    sort: 'queued'
    page_size: "30"
  
  constructor: (@api, @project, @subject_set_id)->
    @query.workflow_id = @project?.links.workflows[0]
    # @query.subject_set_id = @subject_set_id
  
  update: (opts) ->
    @[opt] = value for opt, value of opts
    @query.workflow_id = @project?.links.workflows[0]
    # @query.subject_set_id = @subject_set_id
    
  fetch: ->
    return Promise.resolve [] unless @query.workflow_id?
    @api.type('subjects')
    .get @query
    .then (newSubjects) =>
      @queue.push subject for subject in newSubjects
  
  flush: ->
    subject = null for subject in @queue
    @current = null
    @queue = []
    
  next: ->
    @current = @queue.shift()
    @fetch() if @queue.length < 2
    @current

module.exports = Subjects