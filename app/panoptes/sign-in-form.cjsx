React = require 'react'

module.exports = React.createClass
  displayName: 'SignInForm'

  getInitialState: ->
    busy: false
    currentUser: null
    login: ''
    password: ''
    error: null

  componentDidMount: ->
    @props.auth.listen @handleAuthChange
    @handleAuthChange()

  componentWillUnmount: ->
    @props.auth.stopListening @handleAuthChange

  handleAuthChange: ->
    @setState busy: true, =>
      @props.auth.checkCurrent().then (currentUser) =>
        @setState {currentUser}
        if currentUser?
          @setState login: currentUser.login, password: '********'
        @setState busy: false

  render: ->
    disabled = @state.currentUser? or @state.busy

    <form onSubmit={@handleSubmit}>
      <label>
        User name
        <input type="text" className="standard-input full" name="login" value={@state.login} disabled={disabled} autoFocus onChange={@handleInputChange} />
      </label>

      <br />

      <label>
        Password<br />
        <input type="password" className="standard-input full" name="password" value={@state.password} disabled={disabled} onChange={@handleInputChange} />
      </label>

      <p style={textAlign: 'center'}>
        {if @state.currentUser?
          <div className="form-help">
            Signed in as {@state.currentUser.login}{' '}
            <button type="button" className="minor-button" onClick={@handleSignOut}>Sign out</button>
          </div>

        else if @state.error?
          <div className="form-help error">
            {if @state.error.message.match /invalid(.+)password/i
              Username or password incorrect
            else
              <span>{@state.error.toString()}</span>}{' '}

            <a href="#/reset-password" onClick={@props.onSuccess}>
              Forgot your password?
            </a>
          </div>

        else
          <a href="#/reset-password" onClick={@props.onSuccess}>
            Forgot your password?
          </a>}
      </p>

      <button type="submit" className="standard-button full">
        Sign in
      </button>
    </form>

  handleInputChange: (e) ->
    newState = {}
    newState[e.target.name] = e.target.value
    @setState newState

  handleSubmit: (e) ->
    e.preventDefault()
    @setState working: true, =>
      {login, password} = @state
      @props.auth.signIn {login, password}
        .then (user) =>
          @setState working: false, error: null, =>
            @props.onSuccess? user
        .catch (error) =>
          @setState working: false, error: error, =>
            @getDOMNode().querySelector('[name="login"]')?.focus()
            @props.onFailure? error
      @props.onSubmit? e

  handleSignOut: ->
    @setState busy: true, =>
      auth.signOut().then =>
        @setState busy: false, password: ''
