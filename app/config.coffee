module.exports = 
  auth_mode: 'oauth'
  panoptes:
    appID: '324bbe871acddc1457878b111a6772e25556928644c5ef9ee1784035ad0b0554'
    host: 'https://panoptes.zooniverse.org'
  panoptes_staging:
    appID: '535759b966935c297be11913acee7a9ca17c025f9f15520e7504728e71110a27'
    host: 'https://panoptes-staging.zooniverse.org'
  talk:
    appID: '324bbe871acddc1457878b111a6772e25556928644c5ef9ee1784035ad0b0554'
    host: 'https://talk.zooniverse.org'
    root: ''
  tasks:
    health: 
      label: 'Environmental Health'
      description: 'Monitoring environmental health and sanitation was a major part of the Medical Officer’s role. They reported on contaminated water, noxious fumes and smells and sewerage and drainage. They monitored the health effects of seasonal changes in temperature and smog levels. They also directed the clean-up of areas that were a potential health hazard, removing piles of rubbish, stopping effluent run-off.'
      tools: [{
        label: 'Environmental problem'
        value: 'issue'
        required: true
        subtasks: [{
          label: 'Related health issue or hazard'
          value: 'how'
        },{
          label: 'People affected'
          value: 'who'
        },{
          label: 'The cause of the problem'
          value: 'cause'
        },{
          label: 'Action suggested or taken'
          value: 'action'
        },{
          label: 'Place or location'
          value: 'place'
        }]
      }]
    work: 
      label: 'Work'
      description: 'The medical officer inspected the health impact of London’s trades and industries. From reporting on the working conditions of homeworkers to the effects of tanneries and factories on their surroundings, they had the power to issue fines for breaking local by-laws and public health laws.'
      tools: [{
        label: 'Type of work'
        value: 'type'
        required: true
        subtasks: [{
          label: 'Related health issue or hazard'
          value: 'issue'
        },{
          label: 'People affected'
          value: 'who'
        },{
          label: 'The cause of the problem'
          value: 'cause'
        },{
          label: 'Action suggested or taken'
          value: 'action'
        },{
          label: 'Place or location'
          value: 'place'
        }]
      }]
    # disease:
    #   label: 'Disease'
    #   description: 'The central role of the Medical Officer was to identify and contain significant outbreaks of disease across the city. They gathered statistics on specific infectious diseases. These were usually presented in the form of tables, but they also described specific disease outbreaks in detail, identifying who they affected and where and how they were treated.'
    #   tools: [{
    #     label: 'Name of disease or type of disease'
    #     value: 'type'
    #     required: true
    #     subtasks: [{
    #       label: 'Disease effects'
    #       value: 'how'
    #     },{
    #       label: 'People affected'
    #       value: 'who'
    #     },{
    #       label: 'The cause of the problem'
    #       value: 'cause'
    #     },{
    #       label: 'Action taken'
    #       value: 'action'
    #     },{
    #       label: 'Place or location'
    #       value: 'place'
    #     }]
    #   }]
    food:
      label: 'Food'
      description: 'The medical officer inspected all aspects of the city’s food supply, from food importers and manufacturers to abattoirs, from butchers and bakers shops to street vendors. He was particularly concerned with food adulteration – identifying hidden substances that shouldn’t be there – and incidents of food poisoning.'
      tools: [{
        label: 'Type of food or drink'
        value: 'food'
        required: true
        subtasks: [{
          label: 'Related health issue or hazard'
          value: 'issue'
        },{
          label: 'People affected'
          value: 'who'
        },{
          label: 'The cause of the problem'
          value: 'cause'
        },{
          label: 'Action suggested or taken'
          value: 'action'
        },{
          label: 'Place or location'
          value: 'place'
        }]
      }]
    housing:
      label: 'Housing'
      description: 'Much of the information about housing in the reports is about the living conditions of London’s poor. The medical officers reported on overcrowded slums and the results of poor construction such as leaking sewers, poor ventilation and lack of sunlight due to closely packed houses. They recommended measures such as fumigation after infestations and cleaning after disease outbreaks.'
      tools: [{
        label: 'Housing problem'
        value: 'type'
        required: true
        subtasks: [{
          label: 'Related health issue or hazard'
          value: 'issue'
        },{
          label: 'People affected'
          value: 'who'
        },{
          label: 'The cause of the problem'
          value: 'cause'
        },{
          label: 'Action suggested or taken'
          value: 'action'
        },{
          label: 'Type of housing, place or location'
          value: 'place'
        }]
      }]
