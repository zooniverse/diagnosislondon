React = require 'react/addons'

module.exports = React.createClass
  displayName: 'Profile'

  getInitialState: ->
    user: null

  render: ->
    <div>
      <form className="sign-in-form zooniverse-login-form">
        <div className="loader"></div>

        <header><span data-zooniverse-translate="signInForProfile">Sign in to see your profile.</span></header>
        <label><input type="text" name="username" required="required" data-zooniverse-translate="" data-zooniverse-translate-placeholder="username" /></label>
        <label><input type="password" name="password" required="required" data-zooniverse-translate="" data-zooniverse-translate-placeholder="password" /></label>
        <div className="error-message"></div>
        <div className="action"><button type="submit"><span data-zooniverse-translate="signIn">Sign in</span></button></div>
        <p className="no-account"><span data-zooniverse-translate="noAccount">Don't have an account?</span> <button name="sign-up"><span data-zooniverse-translate="signUp">Sign up</span></button></p>
      </form>

      <nav>
        <button name="turn-page" value="recents" className="active"><span data-zooniverse-translate="recents">Recents</span></button>
        <button name="turn-page" value="favorites"><span data-zooniverse-translate="favorites">Favorites</span></button>
      </nav>

      <div className="recents page zooniverse-paginator empty active">
        <div className="loader"></div>

        <div className="items"></div>

        <nav className="controls">
          <span className="numbered"></span>
        </nav>
      </div>
      <div className="recents-empty empty-message"><span data-zooniverse-translate="recents">Recents</span> (<span data-zooniverse-translate="none">none</span>)</div>

      <div className="favorites page zooniverse-paginator empty">
        <div className="loader"></div>

        <div className="items"></div>

        <nav className="controls">
          <span className="numbered"></span>
        </nav>
      </div>
      <div className="favorites-empty empty-message"><span data-zooniverse-translate="favorites">Favorites</span> (<span data-zooniverse-translate="none">none</span>)</div>
    </div>