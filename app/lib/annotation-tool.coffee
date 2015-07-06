class AnnotationTool
  
  constructor: (@text, options) ->
    @[key] = value for key, value of options
    @el = document.createElement 'b'
    @el.classList.add 'highlight'
    @el.classList.add @type if @type?
    @el.setAttribute 'tabindex', 0
    @wrapHTML @sel
      
    @el.addEventListener 'mouseup', (e) =>
      e.stopPropagation()
    
    @el.style.backgroundColor = @color
  
    {start, end} = @getNodePosition()
    @annotation = 
      type: @type
      text: @el.textContent
      start: start
      end: end
    
  destroy: ->
    @unwrapHTML()
    @annotation = null
  
  wrapHTML: (sel) ->
    range = sel.getRangeAt 0 if sel.rangeCount
    range = range.cloneRange()
    range.surroundContents @el
    sel.removeAllRanges()
    sel.addRange range
  
  unwrapHTML: () ->
    text = @annotation.text
    @el.insertAdjacentHTML 'afterend', text
    parent = @el.parentNode
    parent.removeChild @el
    parent.normalize()
    
  
  getNodePosition: () ->
    start = 0
    for node in @text.childNodes
      if node == @el
        break
      else
        start += node.textContent.length
  
    end = start + node.textContent.length
    start += 1
    {start, end}

module.exports = AnnotationTool