init = require './init'
React = require 'react/addons'
Classifier = require './classifier'
Profile = require './profile'
Panoptes = require 'panoptes-client'

# let's try talking to panoptes by getting the current user and some subjects for a known workflow
_client = new Panoptes
  appID: '535759b966935c297be11913acee7a9ca17c025f9f15520e7504728e71110a27'
  host: 'https://panoptes-staging.zooniverse.org'
  
currentUser = (response) ->
  user = response
  React.render <Profile user=user />, document.querySelector '#profile'
    
  subjectQuery =
    workflow_id: 643 # annoTate, for testing
    sort: 'queued'
  _client.api.type('subjects').get subjectQuery
    
subjects = (response) ->
  React.render <Classifier subjects=response />, document.querySelector '#classify'
  
auth = _client.api.auth

auth
  .checkCurrent()
  .then( currentUser )
  .then( subjects )

window.React = React
