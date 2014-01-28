# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach(Rails.root.join("error_types.csv"), headers: true) do |row|
  ErrorType.create! do |error|
    error.id = row[0]
    error.error_type = row[1]
    error.description = row[2]
  end
end

CSV.foreach(Rails.root.join("next_steps.csv"), headers: true) do |row|
  Step.create! do |step|
    step.description = row[0]
    step.error_type_id = row[1]
  end
end