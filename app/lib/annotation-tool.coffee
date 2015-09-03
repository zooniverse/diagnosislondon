class AnnotationTool
  @count: 0
  
  type: 'health'
  ranges: {}
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @ranges = {}
  
  addRange: (rangeTool) ->
    @ranges[rangeTool.type] ?= []
    @ranges[rangeTool.type].push rangeTool
  
  destroy: ->
    for type of @ranges
      @ranges[type].map (range) ->
        range.destroy()
  
module.exports = AnnotationTool