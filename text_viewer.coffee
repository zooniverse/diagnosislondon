AnnotationTool = require './annotation'

class Base
  dispatchEvent: (eventName, detail) ->
    e = document.createEvent 'CustomEvent'
    e.initCustomEvent eventName, true, true, detail
    @el.dispatchEvent e
    
class TextViewer extends Base
  
  tools: []
  tool_options: {}
  
  CHANGE: 'text-viewer:change-values'
  
  constructor: ->
    @el = document.createElement "pre"
    @el.classList.add 'text-viewer'
    
    # @el.addEventListener 'mouseup', (e) =>
    #   @createAnnotation()
    
    document.addEventListener 'selectionchange', (e) =>
      clearTimeout @selectionEndTimeout if @selectionEndTimeout?

      @selectionEndTimeout = setTimeout @createAnnotation, 3000
  
  createAnnotation: () =>
    console.log 'annotating'
    @selectionEndTimeout = null
    sel = window.getSelection()
    if sel.type is 'Range'
      options =
        sel: sel
      options[key] = value for key, value of @tool_options
      tool = new AnnotationTool @, options
      t.destroy() for t in @tools when t.contains tool or tool.contains t
      @tools.push tool if tool?
      @dispatchEvent @CHANGE
  
  deleteAnnotation: (tool) =>
    
    index = @tools.indexOf tool
    @tools.splice index, 1
    
    @dispatchEvent @CHANGE
  
  load: (text) =>
    @reset()
    @el.innerHTML = text
  
  reset: =>
    @tools[0].destroy() until @tools.length is 0

module.exports = TextViewer
