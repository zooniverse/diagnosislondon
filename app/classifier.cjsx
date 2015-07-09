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
  
  componentDidMount: ->
    @newAnnotation()

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <SubjectTools />
          <SubjectViewer ref='subject_viewer' />
        </div>
      </div>
      <div className="readymade-decision-tree-container">
        <AnnotationToolbar onClick={@onToolbarClick} addTool={@newAnnotation} />
        {@state.annotations.map (tool) =>
          <Annotation key={tool.id} tool={tool} delete={@deleteAnnotation} />
        } 
        <ClassificationSummary />
      </div>
    </div>
    
  onToolbarClick: (e) ->
    @addText @refs.subject_viewer.createAnnotation e.currentTarget.value
  
  newAnnotation: ->
    annotations = @state.annotations
    annotations.push new AnnotationTool
    @setState {annotations}
    
  addText: (textRange) ->
    annotations = @state.annotations
    currentAnnotation = annotations.pop()
    currentAnnotation.addRange textRange if textRange?
    annotations.push currentAnnotation
    @setState {annotations}

  deleteAnnotation: (annotation) ->
    annotations = @state.annotations
    index = annotations.indexOf annotation
    annotations.splice index, 1
    @newAnnotation() if annotations.length == 0
    @setState {annotations}

  load: (subject) ->
    @reset()

  reset: ->
    tools = @state.tools
    tools[0].destroy() until @tools.length is 0
    @setState {tools}