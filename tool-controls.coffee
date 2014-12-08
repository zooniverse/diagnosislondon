{Task} = require 'zooniverse-decision-tree'

class AccessibleControls
  
  template: require('./templates/tool-controls')()
  details: null
  detailTasks: {}
  
  constructor: (options)->
    @[key] = value for key, value of options
    
    @el = document.createElement 'span'
    @el.classList.add 'tool-controls'
    @el.classList.add 'marking-surface-tool-controls'
    @el.setAttribute 'data-selected', true
    @el.insertAdjacentHTML 'beforeEnd', @template
    
    @el.style.left = "#{@tool.el.offsetLeft}px"
    @el.style.top = "#{@tool.el.offsetTop}px"
    
    @el.addEventListener 'change', @onChange
    
    @detailsControls = @el.querySelector '.readymade-details-controls'
    @detailsControls.style.display = 'none'
    
    @taskTypes = 
      text: require './tasks/text'
    
    setTimeout => # Ugh.
      if @details?
        @detailsControls.style.display = ''
        for detail in @details
          @addDetail detail
    
    # @tool.addEvent 'marking-surface:tool:select', @onToolSelect
    # @tool.addEvent 'marking-surface:tool:deselect', @onToolDeselect
    
    delete_button = @el.querySelector 'button[name="readymade-destroy-drawing"]'
    dismiss_button = @el.querySelector 'button[name="readymade-dismiss-details"]'
    
    delete_button.setAttribute 'aria-label', 'Delete'
    
    dismiss_button.addEventListener 'click', (e) =>
      @el.removeAttribute 'data-selected'
    
    delete_button.addEventListener 'click', (e) =>
      @tool.destroy()
      
    delete_button.addEventListener 'keydown', (e) =>
      if @details? && e.which == 9 && e.shiftKey
        dismiss_button.focus()
        e.preventDefault()

    dismiss_button.addEventListener 'keydown', (e) =>
      if e.which == 9 && !e.shiftKey
        delete_button.focus()
        e.preventDefault()
  
  onToolSelect: =>
    @current_focus = document.activeElement
    
  onToolDeselect: =>
    @current_focus.focus()
  
  addDetail: (detail) ->
    form = @el.querySelector 'form'

    unless detail instanceof Task
      detail = new @taskTypes[detail.type] detail
    @detailTasks[detail.key] = detail
    detail.renderTemplate()
    detail.show()
    form.appendChild detail.el
  
  onChange: (e) =>
    for key, task of @detailTasks
      @tool.annotation[key] = task.getValue()

  render: ->
    setTimeout => # Ugh.
      for key, task of @detailTasks
        task.reset @tool.annotation[key]
  
  destroy: ->
    @el.parentNode.removeChild @el
  
module.exports = AccessibleControls