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
        label: 'What is the environmental health issue?'
        value: 'issue'
        required: true
        subtasks: [{
          label: 'Who did it affect?'
          value: 'who'
        },{
          label: 'How did it affect them?'
          value: 'how'
        },{
          label: 'Who or what caused it?'
          value: 'cause'
        },{
          label: 'Was anything done about it?'
          value: 'action'
        },{
          label: 'Is there any place information?'
          value: 'place'
        }]
      }]
    work: 
      label: 'Work'
      description: 'The MOH and his team inspected the health impact of London’s trades and industries. From reporting on the working conditions of homeworkers to the effects of tanneries and factories on their surroundings, they had the power to issue fines for breaking local by-laws and public health laws.'
      tools: [{
        label: 'What type of work is described?'
        value: 'type'
        required: true
        subtasks: [{
          label: 'What health issue, or potential hazard, is it causing?'
          value: 'issue'
          subtasks: [{
            label: 'Did it affect anyone?'
            value: 'who'
          },{
            label: 'Who or what caused it?'
            value: 'cause'
          },{
            label: 'Was anything done about it?'
            value: 'action'
          }]
        },{
          label: 'Is there any place information?'
          value: 'place'
        }]
      }]
    # disease:
 #      label: 'Disease'
 #      description: 'The central role of the Medical Officer was to identify and contain significant outbreaks of disease across the city. They gathered statistics on specific infectious diseases. These were usually presented in the form of tables, but they also described specific disease outbreaks in detail, identifying who they affected and where and how they were treated.'
 #      tools: [{
 #        label: 'Is a specific disease or type of disease named?'
 #        value: 'type'
 #        required: true
 #        subtasks: [{
 #          label: 'Who did it affect?'
 #          value: 'who'
 #        },{
 #          label: 'How did it affect them?'
 #          value: 'how'
 #        },{
 #          label: 'Who or what caused it?'
 #          value: 'cause'
 #        },{
 #          label: 'Was anything done about it?'
 #          value: 'action'
 #        },{
 #          label: 'Is there any place information?'
 #          value: 'place'
 #        }]
 #      }]
    food:
      label: 'Food'
      description: 'The health aspects of food production and sales came under the remit of the Medical Officer. His team of food inspectors investigated all aspects of the city’s food supply, from food importers and manufacturers to abattoirs, from butchers and bakers shops to street vendors. They were particularly concerned with food adulteration – identifying hidden substances that shouldn’t be there – and incidents of food poisoning.'
      tools: [{
        label: 'What is the food or drink?'
        value: 'food'
        required: true
        subtasks: [{
          label: 'What is wrong with it?'
          value: 'issue'
          subtasks: [{
            label: 'Did it affect anyone?'
            value: 'who'
          },{
            label: 'Who or what caused it?'
            value: 'cause'
          },{
            label: 'Was anything done about it?'
            value: 'action'
          }]
        },{
          label: 'Is there any place information?'
          value: 'place'
        }]
      }]
    housing:
      label: 'Housing'
      description: 'Much of the information about housing in the MOH reports is about the living conditions of London’s poor. The Medical Officers were well aware that poverty played a role in the health of Londoners. They reported on overcrowded slums and the results of poor construction such as leaking sewers, poor ventilation and lack of sunlight due to closely packed houses. They recommended measures such as fumigation after infestations and cleaning and whitewashing after disease outbreaks.'
      tools: [{
        label: 'What is the housing problem?'
        value: 'type'
        required: true
        subtasks: [{
          label: 'Did it cause a health issue?'
          value: 'issue'
          subtasks: [{
            label: 'Did it affect anyone?'
            value: 'who'
          },{
            label: 'Did anyone cause it?'
            value: 'cause'
          },{
            label: 'Was anything done about it?'
            value: 'action'
          }]
        },{
          label: 'Is there any place information?'
          value: 'place'
        }]
      }]