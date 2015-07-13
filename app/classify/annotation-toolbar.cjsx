React = require 'react'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'

module.exports = React.createClass
  displayName: 'AnnotationToolbar'
  
  getInitialState: ->
    step: 'choose'
    type: 'health'
  
  render: ->
    <div className="decision-tree">
        {switch @state.step
          when 'choose'
            <ChooseTask onChooseTask={@edit} onFinish={@finish} />
          when 'edit'
            <EditTask type={@state.type} onClick={@selectText} onComplete={@choose}/>
        }
    </div>
  
  edit: (type) ->
    @props.addTool type
    @setState 
      step: 'edit'
      type: type
  
  choose: ->
    @setState step: 'choose'
  
  finish: ->
    @props.onFinish()
  
  selectText: (e) ->
    @props.onClick e
    