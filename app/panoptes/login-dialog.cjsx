React = require 'react'
SignInForm = require './sign-in-form'
RegisterForm = require './register-form'
LoginChangeForm = require './login-change-form'

module.exports = React.createClass
  displayName: 'LoginDialog'

  getDefaultProps: ->
    which: 'sign-in'
    project: {}

  getInitialState: ->
    which: @props.which

  render: ->
    <div className="tabbed-content" data-side="top" onSubmit={@handleSubmit}>
      <nav className="tabbed-content-tabs">
        <button type="button" className="tabbed-content-tab #{('active' if @state.which is 'sign-in') ? ''}" onClick={@goTo.bind this, 'sign-in'}>
          Sign in
        </button>

        <button type="button" className="tabbed-content-tab #{('active' if @state.which is 'register') ? ''}" onClick={@goTo.bind this, 'register'}>
          Register
        </button>
      </nav>

      <div className="content-container">
        {switch @state.which
          when 'login-change' then <LoginChangeForm user={@state.user} onSuccess={@props.onSuccess} />
          when 'sign-in' then <SignInForm  auth={@props.auth} onSuccess={@onSuccessOrLoginChange} />
          when 'register' then <RegisterForm auth={@props.auth} project={@props.project} onSuccess={@props.onSuccess} />}
      </div>
    </div>

  goTo: (which) ->
    @setState {which}

  onSuccessOrLoginChange: (user) ->
    if user.login_prompt
      @setState {which: 'login-change', user: user}
    else
      @props.onSuccess(user)


