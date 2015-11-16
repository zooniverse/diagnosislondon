class Favourites
  favourites: null
  api: null
  query:
    favorite: true
  
  constructor: (@api, @project)->
    @query.project_ids = [@project?.id]
    
  create: (subject)->
    display_name = 'Diagnosis London Favourites'
    project = @project?.id
    subjects = [subject.id]
    favorite = true

    links = {subjects}
    links.project = project if project?
    collection = {favorite, display_name, links}

    @api.type('collections').create(collection).save().then (favourites)=>
      @favourites = favourites
  
  fetch: ->
    @api.type('collections')
      .get @query
      .then ([favorites]) =>
        if favorites?
          @favourites = favorites
  
  check: (subject) ->
    if @favourites?
      @favourites.get('subjects', id: subject.id)
        .then ([subject]) => 
          favourited = subject?
    else
      Promise.resolve false
  
  add: (subject) ->
    if @favourites?
      @favourites.addLink('subjects', [subject.id.toString()])
    else 
      @create subject
  
  remove: (subject) ->
    @favourites.removeLink('subjects', [subject.id.toString()])

module.exports = Favourites