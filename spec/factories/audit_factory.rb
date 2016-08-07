FactoryGirl.define do
  factory :audit do
    vehicle_id 1
    vehicle_name 'Test Car'
    vehicle_location '100 Vehicle Test Location'
    user_id 1
    sold_by 'Tester'
    sold_for 34_334_330.40
  end
end