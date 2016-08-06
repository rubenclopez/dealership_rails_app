app = angular.module('dealershipApp')

app.directive('dsBuyButton', ['$compile', '$filter', 'vehicleService', ($compile, $filter, vehicleService)->
  replace: true
  scope: {}
  link: (scope, element, attrs)->
    scope.amount = null
    scope.id = attrs.vehicleId && +attrs.vehicleId

    _elementParent = element.parent()
    _htmlSnippet = """
      <form class="form-inline buy-directive" name="vehicle-buy-form">
        <div class="form-group">
          <input type="number" step="any" min="0" class="form-control" placeholder="Amount" x-ng-model="amount">
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary" x-ng-click="onSubmit()">Save</button>
        </div>
      </form>
    """

    _previousSnippet = element.parent().html()

    _buildSnippet = (amount)->
      amount = $filter('currency')(amount, '$')

      _soldSnippet = """
        <button class="btn btn-danger button-buy" disabled="disabled">
          Sold at: #{amount}
        </button>
      """

    element.on('click', (evt)->
      return unless attrs.dsBuyButton == 'button'

      evt.preventDefault()
      element.parent().html($compile(angular.element(_htmlSnippet))(scope))
    )

    scope.onSubmit = ()->
      vehicleService.updateVehicle(id: scope.id, sold_at_price: scope.amount).then(
        (vehicle)-> _elementParent.html(_buildSnippet(vehicle.sold_at_price))
      )
])