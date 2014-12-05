class AnnotationTool
  
  constructor: (@text_viewer, options) ->
    @[key] = value for key, value of options
    sel = window.getSelection()
    return unless sel.type is 'Range'
    @el = document.createElement 'b'
    @el.setAttribute 'tabindex', 0
    @wrapHTML sel
  
    @el.addEventListener 'click', (e) =>
      return unless @el.parentNode is @text_viewer.el
      e.preventDefault()
      @text_viewer.deleteAnnotation @
      
    @el.addEventListener 'mouseup', (e) =>
      e.stopPropagation()
    
    @el.style.backgroundColor = @color
    @el.style.color = '#333'
  
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
