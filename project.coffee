require './tasks/annotation'

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
  
  organizations: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Wellcome Library'
    description: 'description'
  },{
    image: '//placehold.it/100.png?text=Example'
    name: 'Constructing Scientific Communities'
    description: 'AHRC research project'
    url: ['http://conscicom.org/', 'https://twitter.com/conscicom']
  },{
    image: '//placehold.it/100.png?text=Example'
    name: 'Zooniverse'
    description: 'Citizen Science Platform'
    url: ['https://www.zooniverse.org/', 'https://twitter.com/the_zooniverse', 'https://github.com/zooniverse']
  }]

  scientists: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Sally Frampton'
    location: 'Oxford, U.K.'
    description: 'Postdoctoral researcher, Constructing Scientific Communities'
    url: 'http://twitter.com/SalsyFrampton'
  }]

  developers: [{
    image: '//placehold.it/100.png?text=Example'
    name: 'Jim O\'Donnell'
    location: 'Oxford, UK'
    description: 'Web Developer'
    url: 'http://twitter.com/pekingspring'
  }]
  
  externalLinks:
    Blog: 'http://blog.zooniverse.org'
    Twitter: 'http://twitter.com/the_zooniverse'
  
  tasks:
    decide:
      type: 'radio'
      question: 'Are there any health issues on this page?'
      choices: [{
        label: 'Yes'
        value: 'yes'
        next: 'annotate'
      },{
        label: 'No'
        value: 'no'
      }]
    annotate:
      type: 'annotation'
      question: 'Mark businesses and health issues in the text'
      choices: [{
        label: 'Business'
        color: 'orange'
        value: 'business'
        checked: true
      },{
        label: 'Health issue'
        color: 'yellow'
        value: 'health'
      },{
        label: 'Action taken'
        color: 'cornflowerblue'
        value: 'action'
      },{
        label: 'Correction'
        color: 'grey'
        value: 'correction'
        details:[{
          type: 'text'
          key: 'new-text'
          choices:[{
            value: 'text'
            key: 'correction'
            label: 'Correction'
          }]
        }]
      }]
      next: 'review'
    review:
      type: 'button'
      question: "Use the 'Back' button to review your work, or click 'Finished' to move on to the next page."
      choices: [{
        label: 'Finished'
        next: null
      }]

  firstTask: 'decide'
  examples: require './field-guide/examples'
  tutorialSteps: require './tutorial/tutorial-steps'

