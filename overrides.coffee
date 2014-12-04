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
  
  $.get( subject.location.ocr ).done (response) ->
    text_viewer.load response
    text_viewer.reset()
  
classify_page.el.on decisionTree.CHANGE, ({originalEvent: {detail}})->
  {key, value} = detail
  
  text_viewer.tool_options = decisionTree.currentTask.getChoice() if key is 'annotate'

classify_page.el.on text_viewer.CHANGE, (e)->
  decisionTree.currentTask.reset (tool.annotation for tool in text_viewer.tools)
