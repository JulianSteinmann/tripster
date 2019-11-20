require "faker"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

Booking.destroy_all
Trip.destroy_all
User.destroy_all

puts 'Creating 200 users...'

200.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.unique.first_name}@gmail.com",
    password: "123456789"
  )
  user.save!
end

puts 'Finished!'

puts 'Creating 100 trips...'

100.times do
  trip = Trip.new(
    user_id: User.all.sample.id,
    destination: ["Paris", "Madrid", "Belfast", "Berlin", "Chicago", "Zurich", "Berlin"].sample,
    origin: ["London", "Manchester", "Liverpool"].sample,
    departure_time: Date.today+rand(20),
    seats: rand(1..6),
    price: rand(12..1000)
  )
  trip.save!
end

puts 'Finished'

puts 'Creating 20 bookings...'

20.times do
  booking = Booking.new(
    trip_id: Trip.all.sample.id,
    user_id: User.all.sample.id,
    status: ["active", "inactive", "pending"].sample
  )
  booking.save!
end

puts 'Finished!'
