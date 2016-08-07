app = angular.module('dealershipApp')

app.controller('vehicleController', ['$scope', '$filter', '$q', 'locationService', 'vehicleService', ($scope, $filter, $q, locationService, vehicleService)->
  _promises = $q.all([locationService.getLocations(), vehicleService.getVehicles()])

  _promises.then(
    (pairs)=>
      [locations, vehicles] = pairs

      _filterCurrency(vehicles)
      _filterDates(vehicles)
      _addStateProperties(vehicles)

      angular.extend($scope,
        whitelistKeys: ['heading', 'description', 'make', 'model', 'year', 'sold_at_price', 'sold_at']
        formBlacklistKeys: ['sold_at_price', 'sold_at']
        vehicles: vehicles
        selectElement:
          name: 'location'
          items: _parseLocations(locations)
      )
  ,
    (error)->
      $scope.vehicles = []
  )

  $scope.onSubmit = (properties)->
    [item, callbackFn] = [properties.item, properties.callback]

    if item.isEditing
      vehicleService.updateVehicle(item).then(
        (success)->
          item.location_id = item.location
          callbackFn()
      ,
        (fail)->
          callbackFn(false)
      )
    else
      vehicleService.postVehicle(item).then(
        (newVehicle)->
          angular.extend(item,
            id: newVehicle.id
            location_id: item.location
          )
          $scope.vehicles.push(item)
          callbackFn()
      ,
        (fail)->
          callbackFn(false)
      )

  $scope.onDestroy = (datum)->
    item = datum.item

    if item.id
      vehicleService.destroyVehicle(item.id).then(
        (success)->
          $scope.vehicles.splice($scope.vehicles.indexOf(item), 1)
      )
    else
      $scope.vehicles.splice($scope.vehicles.indexOf(item), 1)

  $scope.getEditingItem = ()->
    return unless $scope.vehicles

    _.findWhere($scope.vehicles, isEditing: true)

  _addStateProperties = (data)->
    for datum in data
      angular.extend(datum,
        isEditing: false
        isDeleting: false
      )

  _filterCurrency = (data)->
    for datum in data when datum.sold_at_price
      datum.sold_at_price = $filter('currency')(datum.sold_at_price, '$')

  _filterDates = (data)->
    for datum in data when datum.sold_at
      datum.sold_at = $filter('date')(datum.sold_at, 'MM/dd/yyyy HH:mma')

  _parseLocations = (locations)->
    for location in locations
      id: location.id
      name: "#{location.name} | #{location.address} | #{location.city} | #{location.state} | #{location.zip}"
])