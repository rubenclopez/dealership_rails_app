app = angular.module('dealershipApp')

app.controller('locationController', ['$scope', 'locationService', ($scope, locationService)->
  locationService.getLocations().then(
    (locations)=>
      _addStateProperties(locations)
      angular.extend($scope,
        whitelistKeys: ['name', 'address', 'city', 'state', 'zip']
        locations: locations
      )
  ,
    (error)->
      $scope.locations = []
  )

  $scope.onSubmit = (properties)->
    [item, callbackFn] = [properties.item, properties.callback]

    if item.isEditing
      locationService.updateLocation(item).then(
        (success)->
          callbackFn()
      ,
        (fail)->
          callbackFn(false)
      )
    else
      locationService.postLocation(item).then(
        (newLocation)->
          item.id = newLocation.id
          $scope.locations.push(item)
          callbackFn()
      ,
        (fail)->
          callbackFn(false)
      )

  $scope.onDestroy = (datum)->
    item = datum.item

    if item.id
      locationService.destroyLocation(item.id).then(
        (success)->
          $scope.locations.splice($scope.locations.indexOf(item), 1)
      )
    else
      $scope.locations.splice($scope.locations.indexOf(item), 1)

  $scope.getEditingItem = ()->
    return unless $scope.locations

    _.findWhere($scope.locations, isEditing: true)

  _addStateProperties = (data)->
    for datum in data
      angular.extend(datum,
        isEditing: false
        isDeleting: false
      )
])