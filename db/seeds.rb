# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Detector.create(
  name: 'default',
  dp: 1, 
  min_dist: 70,
  param1: 168,
  param2: 64
)

Detector.create(
  name: 'palets',
  dp: 1, 
  min_dist: 80,
  param1: 200,
  param2: 50
)