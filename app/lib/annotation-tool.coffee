class AnnotationTool
  @count: 0
  
  type: 'health'
  issue: null
  subtasks: {}
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @subtasks = {}
  
  addIssue: (rangeTool) ->
    if @issue?
      rangeTool.destroy()
    else
      rangeTool.el.classList.add @type
      @issue = rangeTool
    
  deleteIssue: (rangeTool) ->
    rangeTool.destroy()
    @issue = null
    
  addSubtask: (rangeTool) ->
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
    issue = @issue?.annotation
    subtasks = (@subtasks[type]?.map (range) -> range.annotation) for type of @subtasks
    {issue, subtasks}
  
  destroy: ->
    @issue?.destroy()
    for type of @subtasks
      @subtasks[type].map (subtask) ->
        subtask.destroy()
  
module.exports = AnnotationTool