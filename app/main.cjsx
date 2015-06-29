init = require './init'
React = require 'react/addons'
TabSet = require './lib/tab-control'

nav = document.querySelector 'ul[role=navigation]'
nav_links = nav.querySelectorAll 'a'

tabset = new TabSet

prefix = 'nav'
for link, i in nav_links
  href = link.getAttribute 'href'
  if href[0] == '#'
    tab = link
    tab.id = prefix + '-tab-' + i if tab.id == ''
    panel = document.querySelector href
    if panel?
      # home is a special case
      href = '#' if href == '#home'
      hash = href.replace '#', '#/'
      tabset.add tab, panel, hash == window.location.hash
      do (href) ->
        link.addEventListener 'click', (e) ->
          window.location.hash = href.replace '#', '#/'
          e.preventDefault()

window.addEventListener 'hashchange', (e) ->
  if window.location.hash[0..1] == '#/'
    hash = window.location.hash.replace '#/', '#'
    hash = '#home' if hash == '#'
    panel = document.querySelector hash
    tabset.activate panel

window.React = React
