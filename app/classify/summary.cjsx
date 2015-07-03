React = require 'react/addons'

module.exports = React.createClass
  displayName: 'ClassificationSummary'
  
  render: ->
    <div className="readymade-summary-container" style={display: 'none'}>
      <div className="readymade-classification-summary">
        <p>Thank you. Your classification has been recorded.</p> 
        <div> 
          <p> Do you want to talk about this image? 
            <span className="readymade-existing-comments" style={display: 'none'}> There are already <span className="readymade-existing-comments-count">—</span> comments. </span> 
          </p> 
          <p className="readymade-talk"> 
            <button type="button" name="readymade-dont-talk">No</button> 
            <a href="http://talk.demo.zooniverse.org/#/subjects/APK0000003" className="readymade-talk-link">Yes</a> 
          </p> 
        </div> 
        <div> 
          <p> Share this image: </p> 
          <p className="readymade-social"> 
            <a href="https://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=http%3A%2F%2Ftalk.demo.zooniverse.org%2F%23%2Fsubjects%2FAPK0000003&amp;p[title]=Zooniverse%20classification&amp;p[summary]=Classifying%20on%20the%20Zooniverse!&amp;p[images][0]=Classifying on the Zooniverse!" className="readymade-facebook-link"><i className="fa fa-facebook-square"></i></a> 
            <a href="http://twitter.com/home?status=Classifying%20on%20the%20Zooniverse!%20http%3A%2F%2Ftalk.demo.zooniverse.org%2F%23%2Fsubjects%2FAPK0000003" className="readymade-twitter-link"><i className="fa fa-twitter"></i></a> 
          </p> 
        </div>
      </div>
    </div>