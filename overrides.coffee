require './readymade/overrides.coffee'
TextViewer = require './text_viewer'

currentProject = require 'zooniverse-readymade/current-project'
classify_page = currentProject.classifyPages[0]

{decisionTree, subjectViewer} = classify_page
  
ms = subjectViewer.markingSurface

text_viewer = new TextViewer
subjectViewer.markingSurfaceContainer.append text_viewer.el

# set the image scale if not already set  
ms.on 'marking-surface:add-tool', (tool) ->
  @rescale() if @scaleX is 0

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.maxWidth = subjectViewer.maxWidth
  ms.maxHeight = subjectViewer.maxHeight
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  text_viewer.reset()
  $.get( subject.location.ocr ).done (response) ->
    text_viewer.load response
  
classify_page.el.on decisionTree.CHANGE, ({originalEvent: {detail}})->
  {key, value} = detail
  
  if key is 'annotate'
    choice = decisionTree.currentTask.getChoice()
    options = 
      type: choice.value
      color: choice.color
      label: choice.label
      details: choice.details
    text_viewer.tool_options = options

classify_page.el.on text_viewer.CHANGE, (e)->
  decisionTree.tasks['annotate'].reset (tool.annotation for tool in text_viewer.tools)
