FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    sequence(:email) { |n| "test_#{n}@dealership.com" }
    password 'letmein'

    Role::VALID_ROLES.each do |role|
      sym = "user_with_#{role}_role".to_sym
      factory sym do
        after(:create) do |resource|
          resource.roles << Role[role]
        end
      end
    end

    factory :user_with_location do
      after(:create) do |resource|
        resource.locations << FactoryGirl.build(:location)
      end
    end
  end
end