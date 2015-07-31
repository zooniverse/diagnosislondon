class AnnotationTool
  @count: 0
  
  type: 'health'
  ranges: {}
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @ranges = {}
  
  addRange: (rangeTool) ->
    @ranges[rangeTool.type]?.destroy()
    @ranges[rangeTool.type] = rangeTool
  
  destroy: ->
    @ranges[type].destroy() for type of @ranges
  
module.exports = AnnotationTool