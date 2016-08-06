app = angular.module('dealershipApp')

app.directive('dsTable', ['locationService', (locationService)->
  restrict: 'E',
  scope:
    data: '='
    whitelistKeys: '='
    onDestroy: '&'
    editModeOnly: '='
  template: '''
    <table class="heavy-table col-md-12" x-ng-show="data.length">
      <thead>
        <tr>
          <th x-ng-repeat="key in whitelistKeys">{{ toTitle(key) | uppercase }}</th>
          <th x-ng-show="!editModeOnly">Edit</th>
          <th x-ng-show="!editModeOnly">Delete</th>
        </tr>
      </thead>
      <tbody>
        <tr x-ng-repeat="datum in data">
          <div>
            <td x-ng-repeat="key in whitelistKeys">
              {{ datum[key] }}
            </td>
          </div>
          <div x-ng-show="false">
            <td class="table-button-center" x-ng-click="edit(datum, data)" x-ng-show="!editModeOnly">
              <button class="btn btn-success"><i class="fa fa-pencil" x-ng-class="{'fa-spin': datum.isEditing }" aria-hidden="true"></i></button>
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
    $scope.edit = (item, items)->
      _item.isEditing = false for _item in items
      item.isEditing = true

    $scope.destroy = (item)->
      $scope.onDestroy({item: item})

    $scope.toTitle = (str)->
      str.replace(/_/g, ' ')
  ]
])