React = require 'react/addons'

SubjectTools = require './classify/subject-tools'
SubjectViewer = require './classify/subject-viewer'
Annotation = require './classify/annotation'
AnnotationToolbar = require './classify/annotation-toolbar'
ClassificationSummary = require './classify/summary'
AnnotationTool = require './lib/annotation-tool'

module.exports = React.createClass
  displayName: 'Classifier'
  
  getInitialState: ->
    annotations: []

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer ref='subject_viewer' />
        </div>
      </div>
      <div className="readymade-decision-tree-container">
        <AnnotationToolbar onClick={@onToolbarClick} addTool={@newAnnotation} onFinish={@onFinishPage} />
        {@state.annotations.map (tool) =>
          <Annotation key={tool.id} tool={tool} delete={@deleteAnnotation} />
        } 
        <ClassificationSummary />
      </div>
    </div>
    
  onToolbarClick: (e) ->
    @addText @refs.subject_viewer.createAnnotation e.currentTarget.value
  
  onFinishPage: ->
    console.log @state.annotations
  
  newAnnotation: (type) ->
    annotations = @state.annotations
    annotations.unshift new AnnotationTool type
    @setState {annotations}
    
  addText: (textRange) ->
    annotations = @state.annotations
    currentAnnotation = annotations.shift()
    currentAnnotation.addRange textRange if textRange?
    annotations.unshift currentAnnotation
    @setState {annotations}

  deleteAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    @setState {annotations}

  load: (subject) ->
    @reset()

  reset: ->
    tools = @state.tools
    tools[0].destroy() until @tools.length is 0
    @setState {tools}