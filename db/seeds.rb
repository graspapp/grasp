# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach(Rails.root.join("mastery.csv"), headers: true) do |row|
  Mastery.create! do |mastery|
    mastery.id = row[0]
    mastery.value = row[1]
    mastery.description = row[2]
  end
end

CSV.foreach(Rails.root.join("next_steps.csv"), headers: true) do |row|
  Step.create! do |step|
    step.description = row[0]
    step.mastery_id = row[1]
  end
end