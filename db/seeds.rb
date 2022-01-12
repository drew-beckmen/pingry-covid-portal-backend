# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'
require 'csv'

User.destroy_all 
Isolation.destroy_all 
Quarantine.destroy_all 
Student.destroy_all


u1 = User.create(username: "mlevinson", password: "bigblue1", write: false)
u2 = User.create(username: "dfahey", password: "bigblue2", write: true)
u3 = User.create(username: "ecarannante", password: "bigblue3", write: true)
u4 = User.create(username: "apu", password: "bigblue4", write: true)
u5 = User.create(username: "tchan", password: "bigblue5", write: false)
u6 = User.create(username: "sacharya", password: "bigblue6", write: false)


# CSV.foreach(File.join(Rails.root, "db", "seed.csv"), headers: false) do |row| 
#     first_name, last_name, grade, campus, cohort, veracross_id, email, teacher = row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]
#     Student.create(
#         first_name: first_name, 
#         last_name: last_name, 
#         grade: grade, 
#         campus: campus, 
#         cohort: cohort, 
#         veracross_id: veracross_id, 
#         email: email, 
#         teacher: teacher
#     )
# end 