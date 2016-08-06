FactoryGirl.define do
  factory :vehicle do
    heading 'Ultricies Porta Condimentum'
    description 'Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.'
    make 'Mercedes'
    model 'Coupe'
    year 2010

    association :location

    factory :sold_vehicles do
      sold_at_price '1430.40'
      sold_at '2016-08-02 05:18:06'
    end
  end
end
