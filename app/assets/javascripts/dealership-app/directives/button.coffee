app = angular.module('dealershipApp')

app.directive('dsButton', [()->
  template: '''
    <button class="btn btn-danger" x-ng-click="onClick()"><i class="fa fa-trash" x-ng-class="{'fa-spin': state.spinning }"></i></button>
  '''
  link: (scope, element, attrs)->
    scope.state =
      spinning: false

    scope.onClick = ()->
      scope.state.spinning = true
])