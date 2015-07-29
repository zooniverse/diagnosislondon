React = require 'react'
Favourite = require './favourite'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  render: ->
    <div className="drawing-controls">
      {<Favourite api={@props.api} subject={@props.subject} /> if @props.subject?}
      <label className="readymade-has-clickable"> 
        <input type="checkbox" name="hide-old-marks" /> 
        <span className="readymade-clickable"> 
          <span className="fa fa-eye-slash"></span>
          <span>Hide old marks</span> 
        </span> 
      </label>
      <button name="restart-tutorial"> 
        <span className="readymade-clickable"> 
          <i className="fa fa-graduation-cap"></i>
          <span>Restart tutorial</span> 
        </span> 
      </button> 
    </div>