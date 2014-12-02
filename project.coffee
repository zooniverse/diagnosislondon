
module.exports =
  id: 'wellcome'
  background: 'background.jpg'

  producer: 'Wellcome Library & Zooniverse'
  title: 'Industry and Illness'
  summary: 'Mapping work and public health in the London MOH reports'
  description: 'Short description'

  pages: [{
    'About': '''
      <h2>All about the project</h2>
      <p>This is where we\'ll go into detail.</p>
      <hr />
      <h3>Lorem ipsum dolor sir amet.</h3>
      <p>Break it into sections, add pictures, whatever.</p>
    '''
  }]
  
  tasks:
    annotations:
      type: 'radio'
      question: 'Mark names and issues in the text'
      choices: [{
        label: 'Business name'
        color: 'orange'
        value: 'business'
      },{
        label: 'Health issue'
        color: 'yellow'
        value: 'health'
      }]
      next: 'review'
    review:
      type: 'button'
      question: "Use the 'Back' button to review your work, or click 'Finished' to move on to the next page."
      choices: [{
        label: 'Finished'
        next: null
      }]

  firstTask: 'annotations'

