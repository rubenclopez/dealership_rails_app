# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Roles
Role::VALID_ROLES.each do |role|
  Role.find_or_create_by(name: role)
end

# Owner
user1 = User.create first_name: 'Tom',
                    last_name: 'Napster',
                    email: 'owner@dealership.com',
                    password: 'letmein',
                    roles: [Role['owner']]

# Salesman
user2 = User.create first_name: 'Bob',
                    last_name: 'Norman',
                    email: 'salesman@dealership.com',
                    password: 'letmein',
                    roles: [Role['salesman']]

# Manager
user2 = User.create first_name: 'John',
                    last_name: 'Larson',
                    email: 'manager@dealership.com',
                    password: 'letmein',
                    roles: [Role['manager']]

# Location
loc = Location.create name: 'Vestibulum Venenatis Ullamcorper',
                      address: '2738 Pellentesque Risus',
                      city: 'Bibendum Lorem',
                      state: 'UT',
                      zip: 12345,
                      user: user1

# Location
loc2 = Location.create name: 'Vehicula Inceptos Ultricies',
                       address: '2738 Venenatis Vulputate',
                       city: 'Ipsum Fusce',
                       state: 'AW',
                       zip: 54321,
                       user: user2

# Location
loc3 = Location.create name: 'Consectetur Euismod Mattis',
                       address: '2738 Sollicitudin Amet',
                       city: 'Tellus Ullamcorper',
                       state: 'EA',
                       zip: 34456,
                       user: user2

# Vehicle
Vehicle.create heading: 'Risus Amet Venenatis',
               description: 'Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec id elit non mi porta gravida at eget metus.',
               make: 'Euismod',
               model: 'Magna',
               year: '2000',
               location: loc

# Vehicle
Vehicle.create heading: 'Commodo Ridiculus Pha',
               description: 'Maecenas faucibus mollis interdum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.',
               make: 'Amet',
               model: 'Dapibus',
               year: '2001',
               location: loc2

# Vehicle
Vehicle.create heading: 'Nullam Fringilla Ipsum',
               description: 'Nulla vitae elit libero, a pharetra augue. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.',
               make: 'Quam',
               model: 'Dolor',
               year: '2002',
               location: loc3

