app = angular.module('dealershipApp')

app.directive('useBootstrapSelect', [()->
  require: 'ngModel'
  link: (scope, element, attrs, ngModelController)->
    scope.$watch((()-> ngModelController.$viewValue), (nVal, oVal)->
      return unless nVal != oVal

      element.val(nVal)
      element.selectpicker('refresh')
    )

    _.defer(()-> element.selectpicker())
])