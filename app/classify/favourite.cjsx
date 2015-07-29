React = require 'react'
Favourites = require '../lib/favourites'

module.exports = React.createClass
  displayName: 'FavouriteButton'
  
  favourites: null
  
  getInitialState: ->
    favourited: false
  
  componentWillMount: ->
    @favourites = new Favourites @props.api
    @favourites.fetch()
      .then =>
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
    @favourites?.check subject
      .then (favourited) =>
        @setState {favourited}
      
  toggleFavourite: (e)->
    if @state.favourited
      @removeSubject()
    else
      @addSubject()
  
  removeSubject: ->
    @favourites.remove @props.subject
    @setState favourited: false
  
  addSubject: ->
    @favourites.add @props.subject
    @setState favourited: true