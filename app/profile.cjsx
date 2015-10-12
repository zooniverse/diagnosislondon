React = require 'react'
Favourites = require './lib/favourites'

Thumbnail = React.createClass
  displayName: 'Thumbnail'
  
  getDefaultProps: ->
    width: 200
    height: 200
    origin: 'https://thumbnails.zooniverse.org'
  
  render: ->
    <img src={@getLocation()} />
  
  getLocation: ->
    src = {}
    @props.subject.locations.map (location) ->
      src[k] = v for k, v of location
    
    srcPath = src['image/jpeg']?.split('//').pop()
    "#{@props.origin}/#{@props.width}x#{@props.height}/#{srcPath}"

module.exports = React.createClass
  displayName: 'Profile'
  
  getDefaultProps: ->
    user: null
  
  getInitialState: ->
    recents: []
    favourites: []
  
  componentWillMount: ->
    if @props.user? 
      @props.user
        .get 'recents', {workflow_id: @props.workflow.id, page_size: 12, sort: '-created_at'}
        .then (recents) =>
          @setState {recents}
      
      new Favourites @props.api, @props.project
        .fetch()
        .then (collection) =>
          collection.get('subjects')
            .then (favourites) =>
              @setState {favourites}
  
  render: ->
    if @props.user?
      <div>
          <p>Yo, {@props.user.display_name}!</p>
          <h2>Your favourites</h2>
          <ul>
            {<li key="favourite-#{favourite.id}" className="item"><a href="https://www.zooniverse.org/projects/#{@props.project.slug}/talk/subjects/#{favourite.id}"><Thumbnail subject={favourite} /></a></li> for favourite in @state.favourites}
          </ul>
          <h2>Your recent pages</h2>
          <ul>
            {<li key="recent-#{recent.id}" className="item"><a href="https://www.zooniverse.org/projects/#{@props.project.slug}/talk/subjects/#{recent.links.subject}"><Thumbnail subject={recent} /></a></li> for recent in @state.recents}
          </ul>
      </div>
    else
      <div></div>