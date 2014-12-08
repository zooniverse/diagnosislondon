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
    
    @el.addEventListener 'mouseup', (e) =>
      @createAnnotation()
  
  createAnnotation: () =>
    tool = new AnnotationTool @, @tool_options
    @tools.push tool if tool?
    
    @dispatchEvent @CHANGE
  
  deleteAnnotation: (tool) =>
    text = tool.annotation.text
    tool.el.insertAdjacentHTML 'afterend', text
    @el.removeChild tool.el
    @el.normalize()
    
    index = @tools.indexOf tool
    @tools.splice index, 1
    
    @dispatchEvent @CHANGE
  
  load: (text) =>
    @el.innerHTML = text
  
  reset: =>
    @tools[0].destroy() until @tools.length is 0

module.exports = TextViewer
