ToolControls = require './tool-controls'

class AnnotationTool
  @Controls: ToolControls
  
  constructor: (@text_viewer, options) ->
    @[key] = value for key, value of options
    sel = window.getSelection()
    return unless sel.type is 'Range'
    @el = document.createElement 'b'
    @el.classList.add 'highlight'
    @el.setAttribute 'tabindex', 0
    @wrapHTML sel
    
    if @constructor.Controls?
      @controls = new @constructor.Controls
          tool: this
          details: @details
    
      @text_viewer.el.parentNode.insertBefore @controls.el, @text_viewer.el.nextSibling
  
    @el.addEventListener 'click', (e) =>
      return unless @el.parentNode is @text_viewer.el
      e.preventDefault()
      @controls.el.setAttribute 'data-selected', true
      # @text_viewer.deleteAnnotation @
      
    @el.addEventListener 'mouseup', (e) =>
      e.stopPropagation()
    
    @el.style.backgroundColor = @color
  
    {start, end} = @getNodePosition()
    @annotation = 
      type: @type
      text: @el.textContent
      start: start
      end: end
    
  destroy: =>
  
  wrapHTML: (sel) =>
    range = sel.getRangeAt 0 if sel.rangeCount
    range = range.cloneRange()
    range.surroundContents @el
    sel.removeAllRanges()
    sel.addRange range
    
  
  getNodePosition: () =>
    start = 0
    for node in @text_viewer.el.childNodes
      if node == @el
        break
      else
        start += node.textContent.length
  
    end = start + node.textContent.length
    start += 1
    {start, end}

module.exports = AnnotationTool
