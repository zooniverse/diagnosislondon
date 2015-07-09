class AnnotationTool
  @count: 0
  
  ranges: []
  
  constructor: ->
    AnnotationTool.count++
    @id = "note-#{AnnotationTool.count}"
    @ranges = []
  
  addRange: (rangeTool) ->
    @ranges.push rangeTool
  
module.exports = AnnotationTool