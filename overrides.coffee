require './readymade/overrides.coffee'
AnnotationTool = require './annotation'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

current_task = null

class TextViewer
  
  tools: []
  
  constructor: ->
    @el = document.createElement "pre"
    @el.style.display = "inline-block"
    @el.style.textAlign = "left"
    @el.style.marginLeft = ".5em"
    
    @el.addEventListener 'mouseup', (e) =>
      @createAnnotation current_task.getChoice().value
  
  createAnnotation: (type) =>
    tool = new AnnotationTool @, type
    @tools.push tool
    current_task.reset (tool.annotation for tool in @tools)
    console.log tool.annotation
    
    tool.el.style.backgroundColor = current_task.getChoice().color
    tool.el.style.color = '#333'
  
  deleteAnnotation: (tool) =>
    text = tool.annotation.text
    tool.el.insertAdjacentHTML 'afterend', text
    @el.removeChild tool.el
    @el.normalize()
    
    index = @tools.indexOf tool
    @tools.splice index, 1
    current_task.reset (tool.annotation for tool in @tools)
    
    tool.destroy()
  
  load: (text) =>
    @el.innerHTML = text
  
  reset: =>
    @tools = []

text_viewer = new TextViewer
subjectViewer.markingSurfaceContainer.append text_viewer.el

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.maxWidth = subjectViewer.maxWidth
  ms.maxHeight = subjectViewer.maxHeight
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  $.get( subject.location.ocr ).done (response) ->
    text_viewer.load response
    text_viewer.reset()

classify_page.el.on decisionTree.LOAD_TASK, ({originalEvent: detail: {task}})->
  current_task = task
