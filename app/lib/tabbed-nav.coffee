TabSet = require './tab-control'
tabset = new TabSet

nav = document.querySelector 'ul[role=navigation]'
nav_links = nav.querySelectorAll 'a'

prefix = 'nav'
for link, i in nav_links
  href = link.getAttribute 'href'
  if href[0] == '#'
    tab = link
    tab.id = prefix + '-tab-' + i if tab.id == ''
    panel = document.querySelector href
    current_location = window.location.hash
    current_location = '#/' unless current_location
    if panel?
      # home is a special case
      href = '#' if href == '#home'
      hash = href.replace '#', '#/'
      active = (hash == current_location) || (hash == '#/')
      tabset.add tab, panel, active
      
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