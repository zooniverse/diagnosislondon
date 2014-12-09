RadioTask = require 'zooniverse-readymade/lib/tasks/radio'
DecisionTree = require 'zooniverse-decision-tree'

class AnnotationTask extends RadioTask
  @type: 'annotation'
  annotations: []
  
  choiceTemplate: (choice, i) -> "
  <label class='readymade-choice-input-wrapper'>
    <input type='radio'
      name='#{@key}'
      value='#{choice.value}'
      #{if choice.checked then 'checked="checked"' else ''}
      data-choice-index='#{i}'
    />

    <div class='readymade-choice-clickable readymade-choice-radio'>
      <div class='readymade-choice-tickbox'>
        <div class='readymade-choice-tick'></div>
      </div>

      #{if choice.image? then "<div class='readymade-choice-image'><img src='#{choice.image}' /></div>" else ''}

      <div class='readymade-choice-label'>#{choice.label ? choice.value ? i}</div>

      #{if choice.color? then "<div class='readymade-choice-color' style='color: #{choice.color};'></div>" else ''}
    </div>
  </label>
"
  
  enter: =>
    super
    
    if @choices.length is 1
      @check @choices[0].value
    else
      for choice in @choices
        if choice.checked
          @check choice.value

  reset: (value = @annotations) ->
    @annotations = value
    
  getValue: ->
    @annotations
    
  check: (value) ->
    @el.querySelector('input:checked')?.checked = false

    if value?
      choiceIndex = i for choice, i in @choices when choice.value is value
      @el.querySelector("[data-choice-index='#{choiceIndex}']").checked = true

DecisionTree.registerTask AnnotationTask
DecisionTree.AnnotationTask = AnnotationTask
module?.exports = AnnotationTask