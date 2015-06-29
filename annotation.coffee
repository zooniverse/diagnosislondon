ToolControls = require './tool-controls'

class AnnotationTool
  @Controls: ToolControls
  
  constructor: (@text_viewer, options) ->
    @[key] = value for key, value of options
    @el = document.createElement 'b'
    @el.classList.add 'highlight'
    @el.setAttribute 'tabindex', 0
    @wrapHTML @sel
    
    if @constructor.Controls?
      @controls = new @constructor.Controls
          tool: this
          details: @details
    
      @text_viewer.el.parentNode.insertBefore @controls.el, @text_viewer.el.nextSibling
  
    @el.addEventListener 'click', (e) =>
      return unless @el.parentNode is @text_viewer.el
      e.preventDefault()
      @controls.el.setAttribute 'data-selected', true
      
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
    @text_viewer.deleteAnnotation @
    @unwrapHTML()
    @annotation = null
    @controls.destroy()
  
  wrapHTML: (sel) =>
    range = sel.getRangeAt 0 if sel.rangeCount
    range = range.cloneRange()
    range.surroundContents @el
    sel.removeAllRanges()
    # sel.addRange range
  
  unwrapHTML: () =>
    text = @annotation.text
    @el.insertAdjacentHTML 'afterend', text
    parent = @el.parentNode
    parent.removeChild @el
    parent.normalize()
    
  
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
  
  contains: (tool) =>
    console.log @annotation.start <= tool.annotation.start and @annotation.end >= tool.annotation.end
    return @annotation.start <= tool.annotation.start and @annotation.end >= tool.annotation.end

module.exports = AnnotationTool
