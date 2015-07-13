React = require 'react'

module.exports = React.createClass
  displayName: 'SubjectTools'
  
  render: ->
    <div className="drawing-controls">
      <label className="readymade-has-clickable"> 
        <input type="checkbox" name="favorite" /> 
        <span className="readymade-clickable"> 
          <i className="fa fa-heart-o readymade-clickable-not-checked"></i> 
          <i className="fa fa-heart readymade-clickable-checked" style={color: 'orangered'}></i> 
          <span>Favorite</span> 
        </span> 
      </label>
      <label className="readymade-has-clickable"> 
        <input type="checkbox" name="hide-old-marks" /> 
        <span className="readymade-clickable"> 
          <i className="fa fa-eye-slash readymade-clickable-not-checked"></i> 
          <i className="fa fa-eye-slash readymade-clickable-checked" style={color: 'orangered'}></i> 
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