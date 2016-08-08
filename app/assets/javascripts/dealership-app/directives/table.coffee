app = angular.module('dealershipApp')

app.directive('dsTable', ['locationService', (locationService)->
  restrict: 'E',
  scope:
    data: '='
    whitelistKeys: '='
    transitionKeys: '=?'
    onDestroy: '&'
    editModeOnly: '='
  template: '''
    <table class="heavy-table col-md-12" x-ng-show="data.length">
      <thead>
        <tr>
          <th x-ng-if="transitionKeys" x-ng-click="expandAll()"><i class="fa fa-expand" aria-hidden="true"></i></th>
          <th x-ng-repeat="key in whitelistKeys">{{ toTitle(key) | uppercase }}</th>
          <th x-ng-show="!editModeOnly">Edit</th>
          <th x-ng-show="!editModeOnly">Delete</th>
        </tr>
      </thead>
      <tbody>
        <tr class="do-animate row-animation" x-ng-repeat="datum in data">
          <td class="table-button-center" x-ng-click="datum.isExpanded = !datum.isExpanded"
                                          x-ng-if="transitionKeys">
            <i class="fa" aria-hidden="true" x-ng-class="{'fa-circle': datum.isExpanded, 'fa-circle-o': !datum.isExpanded}"></i>
          </td>
          <td x-ng-repeat="key in whitelistKeys">
            <div class="td-data-disabled" x-ng-class="{'td-data-enabled': addTransition(key) && datum.isExpanded}">
              {{ datum[key] }}
            </div>
          </td>
          <div x-ng-show="false">
            <td class="table-button-center" x-ng-click="edit(datum, data)" x-ng-show="!editModeOnly">
              <button class="btn btn-success">
                <i class="fa fa-pencil" x-ng-class="{'fa-spin': datum.isEditing }" aria-hidden="true"></i>
              </button>
            </td>
            <td class="table-button-center" x-ng-click="destroy(datum)" x-ng-show="!editModeOnly">
              <ds-button></ds-button>
            </td>
          </div>
        </tr>
      </tbody>
    </table>
    <div class="jumbotron col-md-12 no-data" x-ng-show="!data.length"><h3>No Data</h3></div>
  '''
  controller: ['$rootScope', '$scope', ($rootScope, $scope)->
    $scope.allExpanded = false

    $scope.edit = (item, items)->
      _item.isEditing = false for _item in items
      item.isEditing = true

    $scope.destroy = (item)->
      $scope.onDestroy({item: item})

    $scope.toTitle = (str)->
      str.replace(/_/g, ' ')

    $scope.addTransition = (key)->
      _.include($scope.transitionKeys, key)

    $scope.expandAll = ()->
      $scope.allExpanded = !$scope.allExpanded
      datum.isExpanded = $scope.allExpanded for datum in $scope.data
  ]
])