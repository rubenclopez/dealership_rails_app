app = angular.module('dealershipApp')

app.factory('vehicleService', ['$q', 'Restangular', ($q, Restangular)->
  new class LocationService
    keys: []

    constructor: ()->
      @request = Restangular.withConfig (configurer)->
        configurer.setBaseUrl '/'
        configurer.setRequestSuffix '.json'
        configurer.setDefaultHttpFields(cache: true)

    getVehicles: ()->
      @request.all('vehicles').getList().then(
        (vehicles)=>
          _.tap(vehicles, (vehicle)=>
            @_setKeys(vehicles)
          )
      ,
        (error)->
          $q.reject()
      )

    postVehicle: (vehicle)->
      @request.one('vehicles').customPOST(vehicle: vehicle).then(
        (response)-> response.plain()
      ,
        (error)-> $q.reject()
      )

    updateVehicle: (vehicle)->
      @request.one('vehicles', vehicle.id).patch(vehicle: vehicle).then(
        (response)-> response
      ,
        (error)-> $q.reject()
      )

    # TODO: define correct error handling
    destroyVehicle: (id)->
      @request.one('vehicles', id).remove().then(
        (vehicle)-> vehicle
      ,
        (error)-> $q.reject()
      )

    _setKeys: (vehicles)->
      @keys =
        if vehicles.length
          Object.keys(vehicles[0])
        else
          []
])