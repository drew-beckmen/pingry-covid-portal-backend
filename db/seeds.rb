# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'

User.destroy_all 
Isolation.destroy_all 
Quarantine.destroy_all 
Student.destroy_all

u1 = User.create(username: "mlevinson", password: "password")

s1 = Student.create(first_name: "Drew", last_name: "Beckmen", grade: 12, campus: "Basking Ridge", cohort: "Group 1", veracross_id: 143270)
s2 = Student.create(first_name: "Abby", last_name: "Beckmen", grade: 10, campus: "Basking Ridge", cohort: "Group 1", veracross_id: 143270)
s3 = Student.create(first_name: "Sarah", last_name: "Beckmen", grade: 6, campus: "Basking Ridge", cohort: "Group 1", veracross_id: 143270)
s4 = Student.create(first_name: "David", last_name: "Fahey", grade: 1, campus: "Short Hills", cohort: "Group 2", veracross_id: 143270)
s5 = Student.create(first_name: "Jeffrey", last_name: "Xiao", grade: 2, campus: "Short Hills", cohort: "Group 2", veracross_id: 143270)


i1 = Isolation.create(start_isolation: Date.today, date_improving: nil, fever_free: false, end_date: Date.today + 10, student_id: s1.id, completed: false, confirmed: true)
i2 = Isolation.create(start_isolation: Date.today - 2, date_improving: nil, fever_free: false, end_date: Date.today + 8, student_id: s1.id, completed: false, confirmed: false)

q1 = Quarantine.create(exposure: Date.today, student_id: s1.id, completed: false)
q2 = Quarantine.create(exposure: Date.today - 5, student: s1, completed: false)
