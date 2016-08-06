app = angular.module('dealershipApp')

app.controller('auditController', ['$scope', '$filter', 'auditService', ($scope, $filter, auditService)->
  auditService.getAudits().then(
    (audits)=>
      _filterCurrency(audits)
      _filterDates(audits)

      angular.extend($scope,
        whitelistKeys: ['vehicle_id', 'vehicle_name', 'vehicle_location', 'seller_id', 'sold_by', 'sold_for', 'sold_on']
        audits: audits
        editModeOnly: true
      )
  ,
    (error)->
      $scope.audits = []
  )

  _filterCurrency = (data)->
    for datum in data when datum.sold_for
      datum.sold_for = $filter('currency')(datum.sold_for, '$')

  _filterDates = (data)->
    for datum in data when datum.sold_on
      datum.sold_on = $filter('date')(datum.sold_on, 'MM/dd/yyyy HH:mma')
])