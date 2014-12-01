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

classify_page.on classify_page.LOAD_SUBJECT, (e, subject)->
  ms.maxWidth = subjectViewer.maxWidth
  ms.maxHeight = subjectViewer.maxHeight
  ms.rescale 0, 0, subjectViewer.maxWidth, subjectViewer.maxHeight
  
  $.get( subject.location.ocr ).done (response) ->
    text_viewer.innerHTML = response
