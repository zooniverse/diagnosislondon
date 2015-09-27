class AnnotationTool
  @count: 0
  
  type: 'health'
  ranges: {}
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @ranges = {}
  
  addRange: (rangeTool) ->
    rangeTool.el.classList.add @type
    @ranges[rangeTool.type] ?= []
    @ranges[rangeTool.type].push rangeTool
  
  deleteRange: (rangeTool) ->
    index = @ranges[rangeTool.type].indexOf rangeTool
    @ranges[rangeTool.type].splice index, 1
    delete @ranges[rangeTool.type] unless @ranges[rangeTool.type].length
    rangeTool.destroy()
  
  empty: ->
    Object.keys(@ranges).length is 0
  
  destroy: ->
    for type of @ranges
      @ranges[type].map (range) ->
        range.destroy()
  
module.exports = AnnotationTool