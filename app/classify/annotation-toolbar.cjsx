React = require 'react/addons'
ChooseTask = require './tasks/choose'
EditTask = require './tasks/edit'

module.exports = React.createClass
  displayName: 'AnnotationToolbar'
  
  getInitialState: ->
    step: 'choose'
  
  render: ->
    <div className="decision-tree">
        {switch @state.step
          when 'choose'
            <ChooseTask onChooseTask={@edit} />
          when 'edit'
            <EditTask onClick={@selectText} onComplete={@choose}/>
        }
    </div>
  
  edit: ->
    @props.addTool()
    @setState step: 'edit'
  
  choose: ->
    @setState step: 'choose'
  
  selectText: (e) ->
    @props.onClick e
    