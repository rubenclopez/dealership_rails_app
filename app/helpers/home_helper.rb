module HomeHelper
  def format_location(location)
    [location.city, location.state].join(", ")
  end

  def available_sold_state(vehicle)
    button_types = {
      button: {
        available: ['Available', 'btn btn-primary button-buy'],
        sold: ['Sold', 'btn btn-danger button-buy']
      },
      span: {
        available: ['Available', 'label label-primary'],
        sold: ['Sold', 'label label-danger']
      }
    }

    valid_roles = ['owner', 'manager', 'salesman']

    type =
      if user_signed_in? && current_user.has_roles?(*valid_roles)
        :button
      else
        :span
      end

    vehicle_sold = vehicle.has_been_sold? ? :sold : :available
    value, classes = button_types[type][vehicle_sold]

    text =
      if amount = number_to_currency(vehicle.sold_at_price)
        "Sold At: #{amount}"
      else
        value
      end

    content_tag(type, text, class: classes,
                              disabled: vehicle.has_been_sold?,
                              data: { :"ds-buy-button" => type, :"vehicle-id" => vehicle.id})
  end
end
