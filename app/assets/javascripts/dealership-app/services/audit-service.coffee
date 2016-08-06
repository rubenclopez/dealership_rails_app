app = angular.module('dealershipApp')

app.factory('auditService', ['$q', 'Restangular', ($q, Restangular)->
  new class AuditService
    keys: []

    constructor: ()->
      @request = Restangular.withConfig (configurer)->
        configurer.setBaseUrl '/'
        configurer.setRequestSuffix '.json'
        configurer.setDefaultHttpFields(cache: true)

    getAudits: ()->
      @request.all('audits').getList().then(
        (audits)=>
          _.tap(audits.plain(), (audits)=>
            @_setKeys(audits)
          )
      ,
        (error)->
          $q.reject()
      )

    _setKeys: (audits)->
      @keys =
        if audits.length
          Object.keys(audits[0])
        else
          []
])