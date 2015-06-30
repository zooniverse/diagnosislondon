React = require 'react/addons'

subject_text = """
               75
               knowing that the quantity of gas for which they pay is really
               consumed in the street lamps.
               The only complaint connected with gas that came to my
               knowledge related to a nuisance arising out of the parish, viz., at
               the works of the Gas Light and Coke Company, formerly belonging
               to the Imperial Gas Company, and situated in the parish
               of Fulham. Numerous parishioners complained in the month
               of October of very offensive smells proceeding from these works,
               and by desire of your Yestry I investigated the matter, and
               reported thereon in November, the resident engineer at the
               works having given me every facility in the course of my
               enquiry.
               Without going into unnecessary and technical details, it may
               be stated that the cause of the offensive smell was the "lime
               process" by which gas is purified from excess of sulphur compounds.
               The "Gas Referees" have prescribed a maximum of
               impurity to be allowed, and for the winter months this, as before
               stated, is fixed at 25 grains of sulphur in 100 cubic feet of gas.
               The required degree of purity cannot be attained, in the present state
               of chemical knowledge, without the use of lime, and it is said
               that the lime process cannot be employed without creating
               nuisance. The nuisance arises when the covers of the purifiers
               are removed for changing the fouled lime which becomes charged
               with the sulphur and other compounds, and is very offensive.
               The principal ingredients in the nuisance are a gas, sulphuretted
               hydrogen; and a heavy vapour, bisulphide of carbon. The sulphuretted
               hydrogen is removed by passing the gas through
               hydrated peroxide of iron; but no practical means are known
               of dealing with the whole of the bisulphide, some of which therefore
               is allowed to escape into the open air at the highest point of the
               works. A less efficient mode of purification than the lime process is
               that by the oxide of iron. The effect of substituting it for
               the other would be an increase of about 10 grains of sulphur
               in the 100 cubic feet of gas. It is a question of evils, no
               doubt, but I am of opinion it would be better to have more sul-.
               phur left in the gas, even to be burnt in our houses, practically,
               into sulphuric acid, than that the air should be poisoned by so
               foul a stench—if this were an inevitable result. As the
               Company have another manufactory at Kensal Green (in
               this parish), it is right to observe that no complaint had been received
               from that quarter. The lime process is in partial use
               there, and the amount of sulphur impurity during the year
               never exceeded 18 grains in 100 cubic feet. At these works,
               however, the purifiers are in an enclosed building, the site of the
               works is elevated, and the supply of gas to the district is supplemented
               by a 24-inch main from Beckton. The Fulham works
               on the other hand, lie low, the purifiers, which were being increased
               """

module.exports = React.createClass
  displayName: 'Classifier'

  getInitialState: ->
    text: subject_text

  render: ->
    <div className="readymade-classification-interface">
      <div className="readymade-subject-viewer-container">
        <div className="readymade-subject-viewer">
          <div className="drawing-controls">
            <label className="readymade-has-clickable"> <input type="checkbox" name="favorite" /> <span className="readymade-clickable"> <i className="fa fa-heart-o readymade-clickable-not-checked"></i> <i className="fa fa-heart readymade-clickable-checked" style={color: 'orangered'}></i> <span>Favorite</span> </span> </label>
            <label className="readymade-has-clickable"> <input type="checkbox" name="hide-old-marks" /> <span className="readymade-clickable"> <i className="fa fa-eye-slash readymade-clickable-not-checked"></i> <i className="fa fa-eye-slash readymade-clickable-checked" style={color: 'orangered'}></i> <span>Hide old marks</span> </span> </label>
            <button name="restart-tutorial"> <span className="readymade-clickable"> <i className="fa fa-graduation-cap"></i> <span>Restart tutorial</span> </span> </button> 
          </div>
          <div className="readymade-marking-surface-container">
              <pre className="text-viewer">{@state.text}</pre>
          </div>
        </div>
      </div> 
      <div className="readymade-decision-tree-container">
        <div className="decision-tree">
          <button type="button" name="decision-tree-go-back" disabled="">Back</button>
          <div className="decision-tree-task" data-task-type="radio">
            <div className="decision-tree-question">Are there any health issues on this page?</div>
            <div className="decision-tree-choices">
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper">
                  <input type="radio" name="decide" value="yes" data-choice-index="0" /> 
                  <div className="readymade-choice-clickable readymade-choice-radio">
                    <div className="readymade-choice-tickbox">
                      <div className="readymade-choice-tick">
                      </div>
                    </div>
                    <div className="readymade-choice-label">Yes</div>
                  </div>
                </label>
              </div>
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper">
                  <input type="radio" name="decide" value="no" data-choice-index="1" />
                  <div className="readymade-choice-clickable readymade-choice-radio">
                    <div className="readymade-choice-tickbox">
                      <div className="readymade-choice-tick"></div>
                    </div>
                    <div className="readymade-choice-label">No</div>
                  </div>
                </label>
              </div> 
            </div> 
            <div className="decision-tree-confirmation"> <button type="button" name="decision-tree-confirm-task">OK</button> </div>
          </div>
          <div className="decision-tree-task" data-task-type="annotation" style={display: 'none'}>
            <div className="decision-tree-question">Mark businesses and health issues in the text</div>
            <div className="decision-tree-choices">
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper"> 
                  <input type="radio" name="annotate" value="business" checked="checked" data-choice-index="0" /> 
                  <div className="readymade-choice-clickable readymade-choice-radio"> 
                    <div className="readymade-choice-tickbox"> 
                      <div className="readymade-choice-tick"></div> 
                    </div>  
                    <div className="readymade-choice-label">Business</div> 
                    <div className="readymade-choice-color"></div> 
                  </div> 
                </label>
              </div>
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper"> 
                  <input type="radio" name="annotate" value="health" data-choice-index="1" /> 
                  <div className="readymade-choice-clickable readymade-choice-radio"> 
                    <div className="readymade-choice-tickbox"> 
                      <div className="readymade-choice-tick"></div> 
                    </div>  
                    <div className="readymade-choice-label">Health issue</div> 
                    <div className="readymade-choice-color"></div> 
                  </div> 
                </label>
              </div>
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper"> 
                  <input type="radio" name="annotate" value="action" data-choice-index="2" /> 
                  <div className="readymade-choice-clickable readymade-choice-radio"> 
                    <div className="readymade-choice-tickbox"> 
                      <div className="readymade-choice-tick"></div> 
                    </div>  
                    <div className="readymade-choice-label">Action taken</div> 
                    <div className="readymade-choice-color"></div> 
                  </div> 
                </label>
              </div>
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper"> 
                  <input type="radio" name="annotate" value="correction" data-choice-index="3" /> 
                  <div className="readymade-choice-clickable readymade-choice-radio"> 
                    <div className="readymade-choice-tickbox"> 
                      <div className="readymade-choice-tick"></div> 
                    </div>  
                    <div className="readymade-choice-label">Correction</div> 
                    <div className="readymade-choice-color"></div> 
                  </div> 
                </label>
              </div> 
            </div> 
            <div className="decision-tree-confirmation"> 
              <button type="button" name="decision-tree-confirm-task">OK</button> 
            </div>
          </div>
          <div className="decision-tree-task" data-task-type="button" style={display: 'none'}>
            <div className="decision-tree-question">Use the 'Back' button to review your work, or click 'Finished' to move on to the next page.</div> 
            <div className="decision-tree-choices"> 
              <div className="decision-tree-choice">
                <label className="readymade-choice-input-wrapper"> 
                  <input type="button" name="review" value="undefined" data-choice-index="0" /> 
                  <div className="readymade-choice-clickable readymade-choice-button"> 
                    <div className="readymade-choice-tickbox"> 
                      <div className="readymade-choice-tick"></div> 
                    </div>  
                    <div className="readymade-choice-label">Finished</div>  
                  </div> 
                </label>
              </div> 
            </div> 
            <div className="decision-tree-confirmation" style={display: 'none'}> 
              <button type="button" name="decision-tree-confirm-task">OK</button> 
            </div>
          </div>
        </div>
      </div> 
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
    </div> 