class SelectionTool
  @count: 0
  
  constructor: (options) ->
    @[key] = value for key, value of options
    @el = document.createElement 'b'
    @el.classList.add 'highlight'
    @el.classList.add @type if @type?
    @el.setAttribute 'tabindex', 0
    @wrapHTML window.getSelection()
  
    {start, end} = @getNodePosition()
    @annotation =
      type: @type
      subject: @text.getAttribute 'data-subject'
      text: @el.textContent
      start: start
      end: end
    
    @id = "annotation-#{SelectionTool.count}"
    SelectionTool.count++
    
  destroy: ->
    @unwrapHTML()
    @annotation = null
  
  wrapHTML: (sel) ->
    range = sel.getRangeAt 0 if sel.rangeCount
    range = range.cloneRange()
    range.surroundContents @el
    sel.removeAllRanges()
    @text = range.startContainer
  
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

module.exports = SelectionTool