module.exports = 
  auth_mode: 'panoptes'
  panoptes:
    appID: '324bbe871acddc1457878b111a6772e25556928644c5ef9ee1784035ad0b0554'
    host: 'https://panoptes.zooniverse.org'
  panoptes_staging:
    appID: '535759b966935c297be11913acee7a9ca17c025f9f15520e7504728e71110a27'
    host: 'https://panoptes-staging.zooniverse.org'
  tasks:
    health: 
      label: 'New Health Issue'
      tools: [{
        label: 'Business'
        value: 'business'
      },{
        label: 'Health issue'
        value: 'health'
      },{
        label: 'Action taken'
        value: 'action'
      }]
    welfare: 
      label: 'New Welfare Issue'
      tools: [{
        label: 'Welfare 1'
        value: 'welfare1'
      },{
        label: 'Welfare 2'
        value: 'welfare2'
      },{
        label: 'Welfare 3'
        value: 'welfare3'
      }]