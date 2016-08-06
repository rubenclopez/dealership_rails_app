FactoryGirl.define do
  factory :location do
    name 'Happy Lane Building'
    address '100 happy lane'
    city 'Test City'
    state 'UT'
    zip 12345

    association :user

    factory :location_with_vehicle do
      after(:create) do |resource|
        resource.vehicles << FactoryGirl.build(:vehicle)
      end
    end
  end
end