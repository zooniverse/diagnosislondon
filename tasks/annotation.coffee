RadioTask = require 'zooniverse-readymade/lib/tasks/radio'
DecisionTree = require 'zooniverse-decision-tree'

class AnnotationTask extends RadioTask
  @type: 'annotation'
  
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
      @reset @choices[0].value
    else
      for choice in @choices
        if choice.checked
          @reset choice.value

DecisionTree.registerTask AnnotationTask
DecisionTree.AnnotationTask = AnnotationTask
module?.exports = AnnotationTask