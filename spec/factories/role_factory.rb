FactoryGirl.define do
  factory :role do
    name 'test_role'

    factory :owner_role do
      name 'owner'
    end

    factory :manager_role do
      name 'manager'
    end

    factory :salesman_role do
      name 'salesman'
    end
  end
end