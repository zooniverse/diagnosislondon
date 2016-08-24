init = require './init'
config = require './config'
React = require 'react'
ReactDOM = require 'react-dom'
ChooseSubjectSet = require './choose-subject-set'
Classifier = require './classifier'
Profile = require './profile'
Page = require './page'
UserStatus = require './user-status'
ProjectStatistics = require './project-statistics'
Projects = require './lib/projects'
a11y = require 'react-a11y'
Tutorial = require './classify/tutorial'
alert = require './panoptes/alert'

a11y_options =
  includeSrcNode: true

# a11y React, a11y_options

Main = React.createClass
  displayName: 'Main'
  
  projects: null
  client: null
  talk: null
  
  getInitialState: ->
    user: null
    project: null
    workflow: null
    subject_set: null
  
  componentWillMount: ->
    subject_set_id = window.location.hash.split('/')[2]
    subject_set_id = null if subject_set_id == ''
    subject_set_id ?= localStorage.getItem 'subject-set-id'
    
    @client = require 'panoptes-client/lib/api-client'
    
    @talk = require 'panoptes-client/lib/talk-client'
      
    @projects = new Projects @client
    
    @auth = require 'panoptes-client/lib/oauth'
    @auth.init config.panoptes.appID
      .then @init
      .then =>
        @changeSubjectSet subject_set_id if subject_set_id?
    
  componentDidUpdate:->
    @setBackground @state.project if @state.project?
    ReactDOM.render <Profile project={@state.project} workflow={@state.workflow} user={@state.user} api={@client} />, document.querySelector '#profile'
    ReactDOM.render <UserStatus user={@state.user} auth={@auth} onSignOut={@signOut} />, document.querySelector '#user-status'
    ReactDOM.render <ChooseSubjectSet workflow={@state.workflow} onChange={@changeSubjectSet} />, document.querySelector '#reports'
    ReactDOM.render <Page project={@state.project} url_key='science_case' />, document.querySelector '#about'
    ReactDOM.render <Classifier project={@state.project} workflow={@state.workflow} user={@state.user} api={@client} talk={@talk} subject_set={@state.subject_set} />, document.querySelector '#classify'
  
  componentDidMount: ->
    document.querySelector('#classify').addEventListener 'activate', @startTutorial
  
  render: ->
    <div className="readymade-home-page-content">
      <div className="readymade-creator">
          <div className="readymade-project-producer">Wellcome Library &amp; Zooniverse</div>
          <h1 className="readymade-project-title">{@state.project?.display_name}</h1>
      </div>
      <div className="readymade-project-summary"> {@state.project?.description} </div>
      <div className="readymade-project-description"> {@state.project?.introduction} </div>
      {<div className="readymade-footer"> <a href="#/classify" className="major-button"> Get started! </a> </div> if @state.project?}
      <ProjectStatistics project={@state.project} workflow={@state.workflow} />
    </div>
  
  setBackground: (project) ->
    project.get 'background'
      .then (background) ->
        document.querySelector '#site-background'
          .style.backgroundImage = "url(#{background.src})"
  
  signOut: ->
    @client.headers['Authorization'] = null
    localStorage.removeItem 'bearer_token'
    console.log 'signed out'
    @toggleProfile null
    @setState user: null
          
  init: ->
    @auth
      .checkCurrent()
      .then (user) =>
        @toggleProfile user
        @projects?.fetch().then =>
          project = @projects.current()
          @client.type 'workflows'
            .get '2368'
            .then (workflow) =>
              @setState {user, project, workflow}
  
  toggleProfile: (user) ->
    profile_link = document.querySelector '[href="#profile"]'
    profile_link.setAttribute 'aria-hidden', !user?
    if user?
      profile_link.setAttribute 'tabindex', 0
    else
      profile_link.setAttribute 'tabindex', -1
    window.location.hash = '#/' if window.location.hash == '#/profile' and !user?
    
  changeSubjectSet: (subject_set_id) ->
    @client.type 'subject_sets'
    .get subject_set_id
    .then (subject_set) =>
      localStorage.setItem 'subject-set-id', subject_set.id
      @setState {subject_set}
  
  renderClassifier: ->
    if @state.subject_set?
      ReactDOM.render <Classifier project={@state.project} workflow={@state.workflow} user={@state.user} api={@client} talk={@talk} subject_set={@state.subject_set} />, document.querySelector '#classify'
    else
      ReactDOM.render <ChooseSubjectSet workflow={@state.workflow} onChange={@changeSubjectSet} />, document.querySelector '#classify'
  
  startTutorial: ->
    document.querySelector('#classify').removeEventListener 'activate', @startTutorial
    Tutorial.checkIfCompleted @state.user, @state.project
      .then (completed) =>
        unless completed
          @client.type 'tutorials'
            .get
              project_id: @state.project.id
            .then ([tutorial]) =>
              alert (resolve) =>
                <Tutorial tutorial={tutorial} api={@client} user={@state.user} project={@state.project} onFinish={resolve} />
          
            
ReactDOM.render <Main />, document.querySelector '#home'