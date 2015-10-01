React = require 'react'

Thumbnail = React.createClass
  displayName: 'Thumbnail'
  
  getDefaultProps: ->
    width: 200
    height: 200
    origin: 'https://thumbnails.zooniverse.org'
  
  render: ->
    <img src={@getLocation()} />
  
  getLocation: ->
    src = null
    for location in @props.recent.locations
      src = location['image/jpeg']
    
    srcPath = src.split('//').pop()
    "#{@props.origin}/#{@props.width}x#{@props.height}/#{srcPath}"

module.exports = React.createClass
  displayName: 'Profile'
  
  getDefaultProps: ->
    user: null
  
  getInitialState: ->
    recents: []
  
  componentWillMount: ->
    if @props.user? 
      @props.user
        .get 'recents', {workflow_id: @props.workflow.id, page_size: 12, sort: '-created_at'}
        .then (recents) =>
          @setState {recents}
  
  render: ->
    if @props.user?
      <div>
          <p>Yo, {@props.user.display_name}!</p>
          <h2>Your recent pages</h2>
          <ul>
            {<li key="recent-#{recent.id}" className="item"><a href="https://www.zooniverse.org/projects/eatyourgreens/diagnosis-london/talk/subjects/#{recent.links.subject}"><Thumbnail recent={recent} /></a></li> for recent in @state.recents}
          </ul>
      </div>
    else
      <div></div>