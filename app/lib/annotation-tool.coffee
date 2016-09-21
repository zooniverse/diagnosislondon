SelectionTool = require './selection-tool'

class AnnotationTool
  @count: 0
  
  type: 'health'
  issue: null
  subtasks: {}
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @subtasks = {}
  
  addIssue: (type = 'issue') ->
    if @issue?
      document.getSelection().removeAllRanges()
    else
      rangeTool = @createSelection type
      return unless rangeTool?
      rangeTool.el.classList.add @type
      @issue = rangeTool
    
  deleteIssue: (rangeTool) ->
    rangeTool.destroy()
    @issue = null
    
  addSubtask: (type) ->
    rangeTool = @createSelection type
    return unless rangeTool?
    rangeTool.el.classList.add @type
    @subtasks[rangeTool.type] ?= []
    @subtasks[rangeTool.type].push rangeTool
  
  deleteSubtask: (rangeTool) ->
    index = @subtasks[rangeTool.type].indexOf rangeTool
    @subtasks[rangeTool.type].splice index, 1
    delete @subtasks[rangeTool.type] unless @subtasks[rangeTool.type].length
    rangeTool.destroy()
  
  empty: ->
    !@issue?
  
  value: ->
    value = @issue?.annotation
    subtasks = ((@subtasks[type]?.map (range) -> range.annotation) for type of @subtasks)
    if subtasks.length
      subtasks = subtasks.reduce (a, b) -> [a..., b...]
    value.type = @type
    value.details = subtasks
    value
  
  destroy: ->
    @issue?.destroy()
    for type of @subtasks
      @subtasks[type].map (subtask) ->
        subtask.destroy()
  
  createSelection: (type) ->
    sel = document.getSelection()
    return null unless sel.anchorNode?.parentNode.getAttribute 'data-subject'
    if sel.rangeCount
      options =
        type: type
      tool = new SelectionTool options
  
module.exports = AnnotationTool