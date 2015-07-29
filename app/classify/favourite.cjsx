React = require 'react'

module.exports = React.createClass
  displayName: 'FavouriteButton'
  
  favourites: null
  
  getInitialState: ->
    favourited: false
  
  componentWillMount: ->
    @props.api.type('collections').get({project_id: 908, favorite: true})
      .then ([favorites]) =>
        if favorites?
          @favourites = favorites
          @checkFavourite @props.subject
  
  componentWillUnmount: ->
    @favourites = null

  componentWillReceiveProps: (newProps)->
    @checkFavourite newProps.subject unless newProps.subject is @props.subject
  
  render: ->
    <label className="readymade-has-clickable"> 
      <input type="checkbox" name="favorite" checked={@state.favourited} onChange={@toggleFavourite} /> 
      <span className="readymade-clickable"> 
        <span className="fa fa-heart#{if @state.favourited then '' else '-o'}"></span>
        <span>Favourite</span> 
      </span> 
    </label>
  
  checkFavourite: (subject) ->
    @favourites?.get('subjects', id: subject.id)
      .then ([subject]) => 
        favourited = subject?
        @setState {favourited}
    
  createFavourites: ->
    display_name = 'Diagnosis London Favourites'
    project = 908
    subjects = [@props.subject.id]
    favorite = true

    links = {subjects}
    links.project = project if project?
    collection = {favorite, display_name, links}

    @setState favourited: true
    @props.api.type('collections').create(collection).save().then (favourites)=>
      @favourites = favourites
      
  toggleFavourite: (e)->
    if not @favourites?
      @createFavourites()
    else if @state.favourited
      @removeSubject()
    else
      @addSubject()
  
  removeSubject: ->
    @favourites.removeLink('subjects', [@props.subject.id.toString()])
    @setState favourited: false
  
  addSubject: ->
    @favourites.addLink('subjects', [@props.subject.id.toString()])
    @setState favourited: true