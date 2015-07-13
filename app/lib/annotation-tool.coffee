class AnnotationTool
  @count: 0
  
  type: 'health'
  ranges: []
  
  constructor: (@type) ->
    AnnotationTool.count++
    @id = "#{@type}-#{AnnotationTool.count}"
    @ranges = []
  
  addRange: (rangeTool) ->
    @ranges.push rangeTool
  
module.exports = AnnotationTool