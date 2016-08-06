app = angular.module('dealershipApp')

app.factory('locationService', ['$q', 'Restangular', ($q, Restangular)->
  new class LocationService
    keys: []

    constructor: ()->
      @request = Restangular.withConfig (configurer)->
        configurer.setBaseUrl '/'
        configurer.setRequestSuffix '.json'
        configurer.setDefaultHttpFields(cache: true)

    getLocations: ()->
      @request.all('locations').getList().then(
        (locations)=>
          _.tap(locations, (locations)=>
            @_setKeys(locations)
          )
      ,
        (error)->
          $q.reject()
      )

    postLocation: (location)->
      @request.one('locations').customPOST(location: location).then(
        (response)-> response.plain()
      ,
        (error)-> $q.reject()
      )

    updateLocation: (location)->
      @request.one('locations', location.id).patch(location: location).then(
        (response)-> response
      ,
        (error)-> $q.reject()
      )

    # TODO: define correct error handling
    destroyLocation: (id)->
      @request.one('locations', id).remove().then(
        (locations)-> locations
      ,
        (error)-> $q.reject()
      )

    _setKeys: (locations)->
      @keys =
        if locations.length
          Object.keys(locations[0])
        else
          []
])