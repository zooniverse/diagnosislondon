React = require 'react'
PromiseToSetState = require './promise-to-set-state'


REMOTE_CHECK_DELAY = 1000
MIN_PASSWORD_LENGTH = 8

module.exports = React.createClass
  displayName: 'RegisterForm'

  mixins: [PromiseToSetState]

  getDefaultProps: ->
    project: {}

  getInitialState: ->
    user: null
    badNameChars: null
    nameConflict: null
    passwordTooShort: null
    passwordsDontMatch: null
    emailConflict: null
    agreedToPrivacyPolicy: null
    error: null

  componentDidMount: ->
    @props.auth.listen @handleAuthChange
    @handleAuthChange()

  componentWillUnmount: ->
    @props.auth.stopListening @handleAuthChange

  handleAuthChange: ->
    @promiseToSetState user: @props.auth.checkCurrent()

  render: ->
    {badNameChars, nameConflict, passwordTooShort, passwordsDontMatch, emailConflict} = @state

    <form onSubmit={@handleSubmit}>
      <label>
        <span className="columns-container inline spread">
          User name
          {if badNameChars?.length > 0
            <span>Only letters, numbers, '.', '_', and '-'.</span>
          else if nameConflict?
            if nameConflict
              <span className="form-help error">
                That username is taken 
                <a href="#/reset-password" onClick={@props.onSuccess}>
                  Forget your password?
                </a>
              </span>
            else
              <span className="form-help success">
                Looks good
              </span>}
        </span>
        <input type="text" ref="name" className="standard-input full" disabled={@state.user?} autoFocus onChange={@handleNameChange} />
      </label>

      <br />

      <label>
        <span className="columns-container inline spread">
          Password
          {if passwordTooShort
            <span>Must be at least 8 characters</span>
          }
        </span>
        <input type="password" ref="password" className="standard-input full" disabled={@state.user?} onChange={@handlePasswordChange} />
      </label>

      <br />

      <label>
        <span className="columns-container inline spread">
          Confirm password<br />
          {if passwordsDontMatch?
            if passwordsDontMatch
              <span>These don’t match</span>
            else if not passwordTooShort
              <span>Looks good</span>
          }
        </span>
        <input type="password" ref="confirmedPassword" className="standard-input full" disabled={@state.user?} onChange={@handlePasswordChange} />
      </label>

      <br />

      <label>
        <span className="columns-container inline spread">
          Email address
          {if emailConflict?
            if emailConflict
              <span className="form-help error">
                An account with this address already exists 
                <a href="#/reset-password" onClick={@props.onSuccess}>
                  Forgot your password?
                </a>
              </span>
            else
              <span>Looks good</span>
          else
            <span>Required</span>
          }
        </span>
        <input type="text" ref="email" className="standard-input full" disabled={@state.user?} onChange={@handleEmailChange} />
      </label>

      <br />

      <label>
        <span className="columns-container inline spread">
          Real name
        </span>
        <input type="text" ref="realName" className="standard-input full" disabled={@state.user?} />
        We’ll use this to give you credit in scientific papers, posters, etc
      </label>

      <br />
      <br />

      <label>
        <input type="checkbox" ref="agreesToPrivacyPolicy" disabled={@state.user?} onChange={@handlePrivacyPolicyChange} />
        You agree to our <a target="_blank" href="#/privacy">privacy policy</a> (required)
      </label>

      <br />
      <br />

      <label>
        <input type="checkbox" ref="okayToEmail" defaultChecked={true} disabled={@state.user?} onChange={@forceUpdate.bind this, null} />
        It’s okay to send me email every once in a while.
      </label><br />

      <label>
        <input type="checkbox" ref="betaTester" disabled={@state.user?} onChange={@forceUpdate.bind this, null} />
        I’d like to help test new projects, and be emailed when they’re available.
      </label><br />

      <p style={textAlign: 'center'}>
        {if @state.user?
          <span className="form-help warning">
            Signed in as {@state.user.login}
            <button type="button" className="minor-button" onClick={@handleSignOut}>Sign out</button>
          </span>
        else if @state.error?
          <span className="form-help error">{@state.error.toString()}</span>
        else
          <span>&nbsp;</span>}
      </p>

      <div>
        <button type="submit" className="standard-button full">
          Register
        </button>
      </div>
    </form>

  handleNameChange: ->
    name = @refs.name.getDOMNode().value

    exists = name.length isnt 0
    badChars = (char for char in name.split('') when char.match(/[\w\-\']/) is null)

    @setState
      badNameChars: badChars
      nameConflict: null
      nameExists: exists

    if exists and badChars.length is 0
      @debouncedCheckForNameConflict ?= debounce @checkForNameConflict, REMOTE_CHECK_DELAY
      @debouncedCheckForNameConflict name

  debouncedCheckForNameConflict: null
  checkForNameConflict: (username) ->
    @promiseToSetState nameConflict: auth.register(login: username).catch (error) ->
      error.message.match(/login(.+)taken/mi) ? false

  handlePasswordChange: ->
    password = @refs.password.getDOMNode().value
    confirmedPassword = @refs.confirmedPassword.getDOMNode().value

    exists = password.length isnt 0
    longEnough = password.length >= MIN_PASSWORD_LENGTH
    asLong = confirmedPassword.length >= password.length
    matches = password is confirmedPassword

    @setState
      passwordTooShort: if exists then not longEnough
      passwordsDontMatch: if exists and asLong then not matches

  handleEmailChange: ->
    @promiseToSetState emailConflict: Promise.resolve null # Cancel any existing request.

    email = @refs.email.getDOMNode().value
    if email.match /.+@.+\..+/
      @debouncedCheckForEmailConflict ?= debounce @checkForEmailConflict, REMOTE_CHECK_DELAY
      @debouncedCheckForEmailConflict email

  debouncedCheckForEmailConflict: null
  checkForEmailConflict: (email) ->
    @promiseToSetState emailConflict: auth.register({email}).catch (error) ->
      error.message.match(/email(.+)taken/mi) ? false

  handlePrivacyPolicyChange: ->
    @setState agreesToPrivacyPolicy: @refs.agreesToPrivacyPolicy.getDOMNode().checked

  isFormValid: ->
    {badNameChars, nameConflict, passwordsDontMatch, emailConflict, agreesToPrivacyPolicy, nameExists} = @state
    badNameChars?.length is 0 and not nameConflict and not passwordsDontMatch and not emailConflict and nameExists and agreesToPrivacyPolicy

  handleSubmit: (e) ->
    e.preventDefault()
    login = @refs.name.getDOMNode().value
    password = @refs.password.getDOMNode().value
    email = @refs.email.getDOMNode().value
    credited_name = @refs.realName.getDOMNode().value
    global_email_communication = @refs.okayToEmail.getDOMNode().checked
    beta_email_communication = @refs.betaTester.getDOMNode().checked
    project_id = @props.project?.id

    @setState error: null
    @props.onSubmit?()
    auth.register {login, password, email, credited_name, global_email_communication, project_id, beta_email_communication}
      .then =>
        @props.onSuccess? arguments...
      .catch (error) =>
        @setState {error}
        @props.onFailure? arguments...

  handleSignOut: ->
    auth.signOut()
