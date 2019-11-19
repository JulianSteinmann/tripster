require "faker"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating 40 users...'

40.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.unique.first_name}@gmail.com",
    password: "123456789"
  )
  user.save!
end

puts 'Finished!'

puts 'Creating 20 trips...'

20.times do
  trip = Trip.new(
    user_id: rand(1..40),
    destination: ["Paris", "Madrid", "Belfast", "Berlin", "Chicago", "Zurich", "Berlin"].sample,
    origin: "London",
    departure_time: Date.new,
    seats: rand(1..6),
  )
  trip.save!
end

puts 'Finished'

puts 'Creating 5 bookings...'

5.times do
  booking = Booking.new(
    trip_id: rand(1..20),
    user_id: rand(1..40),
    status: ["active", "inactive", "pending"].sample
  )
  booking.save!
end

puts 'Finished!'
