app = angular.module('dealershipApp')

app.directive('dsForm', ['$rootScope', ($rootScope)->
  restrict: 'E',
  scope:
    data: '='
    whitelistKeys: '='
    blacklistKeys: '='
    selectElement: '='
    resource: '@'
    onSubmit: '&'
  template: '''
    <form class="form-horizontal">
      <div class="form-group" x-ng-repeat="key in getKeys()">
        <label for="{{ key }}_id" class="control-label col-sm-2">{{ key | uppercase }}</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="{{ getInputName(key) }}" id="{{ getInputId(key) }}" x-ng-model="_data[key]">
        </div>
      </div>
      <div class="form-group" x-ng-show="selectElement">
        <label for="{{ selectElement.name }}_id" class="control-label col-sm-2">{{ selectElement.name | uppercase }}</label>
        <select class="select-element" name="{{ getInputName(selectElement.name) }}" x-use-bootstrap-select x-ng-model="_data[selectElement.name]">
          <option x-ng-repeat="item in selectElement.items" value="{{ item.id }}">{{ item.name }}</option>
        </select>
      </div>
      <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2"> <!--New div, offset because there is no label -->
          <button type="submit" class="btn btn-primary" x-ng-click="submitHandler()" x-ng-disabled="isSubmitting">
            <i class="fa fa-circle-o-notch fa-spin" aria-hidden="true" x-ng-if="isSubmitting"></i>
            {{ isSubmitting ? 'Submitting' : 'Submit' }}
          </button>
        </div>
        <div class="col-sm-1">
          <button type="cancel" class="btn btn-danger" x-ng-click="cancelHandler()">Cancel</button>
        </div>
      </div>
    </form>
  '''
  controller: ['$scope', ($scope)->
    $scope.isSubmitting = false

    _getDefaultValues = ()->
      angular.copy(
        id: null
        name: null
        address: null
        city: null
        state: null
        zip: null
      )

    $scope.$watch('data',
      (nVal, oVal)->
        $scope._data = $scope.data || _getDefaultValues()
        $scope._data.location = $scope._data.location_id
    )

    $scope.getInputName = (name)->
      "#{$scope.resource}[#{name}]"

    $scope.getInputId = (name)->
      [$scope.resource, name].join('_')

    $scope.getKeys = ()->
      return unless $scope.whitelistKeys

      (key for key in $scope.whitelistKeys when !_.contains($scope.blacklistKeys, key))

    $scope.submitHandler = ()->
      $scope.isSubmitting = true
      $scope.onSubmit(
        item: $scope._data
        callback: ()=>
          $scope.isSubmitting = false
      )

    $scope.cancelHandler = ()->
      $scope._data = _getDefaultValues()
      $scope.data.isEditing = false if $scope.data
  ]
])