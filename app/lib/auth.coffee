extractToken = (hash) ->
  match = hash.match(/access_token=(\w+)/)
  if !!match && match[1]
    match[1]
  else
    null
    
class Auth
  
  constructor: (@api) ->
    if token = @_tokenExists()
      @_setupAuth token
    
  checkCurrent: ->
    @api.get '/me'
      .then ([user]) =>
        user
      .catch (error) =>
        null
  
  signOut: ->
    @_removeToken()
    @api.auth.emit 'change'
  
  _setupAuth: (token) ->
      @api.headers['Authorization'] = 'Bearer ' + token
      localStorage.setItem 'bearer_token', token

  _tokenExists: ->
    extractToken(window.location.hash) || localStorage.getItem('bearer_token')

  _getToken: ->
    token = null
    token ?= localStorage.getItem 'bearer_token'
    token ?= extractToken window.location.hash

    token

  _setToken: (token) ->
    @api.headers['Authorization'] = 'Bearer ' + token
    localStorage.setItem 'bearer_token', token

  _removeToken: ->
    @api.headers['Authorization'] = null
    localStorage.removeItem 'bearer_token'

module.exports = Auth