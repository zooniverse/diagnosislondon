require './readymade/overrides.coffee'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

text_viewer = document.createElement "pre"
subjectViewer.markingSurfaceContainer.append text_viewer
text_viewer.style.display = "inline-block"
text_viewer.style.textAlign = "left"
text_viewer.style.marginLeft = ".5em"

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

createAnnotation = (sel) ->
  return unless sel.type is 'Range'
  wrapper = document.createElement 'b'
  wrapper.setAttribute 'tabindex', 0
  wrapHTML( sel, wrapper )
  
  wrapper.addEventListener 'click', (e) ->
    e.preventDefault()
    unwrapHTML @
  wrapper.addEventListener 'mouseup', (e) ->
    e.stopPropagation()
  
  {start, end} = getNodePosition wrapper
  annotation = 
    text: wrapper.textContent
    start: start
    end: end
    node: wrapper
  
  annotation
  
wrapHTML = (sel, el) ->
  range = sel.getRangeAt 0 if sel.rangeCount
  range = range.cloneRange()
  range.surroundContents el
  el.style.color = 'yellow'
  sel.removeAllRanges()
  sel.addRange range
  

unwrapHTML = (el) ->
  text = el.textContent
  el.insertAdjacentHTML 'afterend', text
  text_viewer.removeChild el
  text_viewer.normalize()

getNodePosition = (el) ->
  start = 0
  for node in text_viewer.childNodes
    if node == el
      break
    else
      start += node.textContent.length
  
  end = start + node.textContent.length
  start += 1
  {start, end}

text_viewer.addEventListener 'mouseup', (e) ->
  annotation = createAnnotation window.getSelection()
  console.log annotation
  

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.maxWidth = subjectViewer.maxWidth
  ms.maxHeight = subjectViewer.maxHeight
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  $.get( subject.location.ocr ).done (response) ->
    text_viewer.innerHTML = response
