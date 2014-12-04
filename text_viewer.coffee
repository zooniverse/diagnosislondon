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
    @el.style.display = "inline-block"
    @el.style.textAlign = "left"
    @el.style.marginLeft = ".5em"
    
    @el.addEventListener 'mouseup', (e) =>
      @createAnnotation @tool_options.value
  
  createAnnotation: (type) =>
    tool = new AnnotationTool @, type
    @tools.push tool
    console.log tool.annotation
    
    tool.el.style.backgroundColor = @tool_options.color
    tool.el.style.color = '#333'
    
    @dispatchEvent @CHANGE
  
  deleteAnnotation: (tool) =>
    text = tool.annotation.text
    tool.el.insertAdjacentHTML 'afterend', text
    @el.removeChild tool.el
    @el.normalize()
    
    index = @tools.indexOf tool
    @tools.splice index, 1
    
    tool.destroy()
    
    @dispatchEvent @CHANGE
  
  load: (text) =>
    @el.innerHTML = text
  
  reset: =>
    @tools = []

module.exports = TextViewer
