# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts '==== cleaning DB ===='
User.destroy_all
Company.destroy_all


puts '==== creating owners data ===='
a_owner = {level: 0, name: 'A_owner', email: "a0@a.com"}
b_owner = {level: 0, name: 'B_owner', email: "b0@b.com"}

puts '==== creating Companiers with owners ===='
a_company = Company.new(name: 'Empresa A', users_attributes: [ a_owner ])
b_company = Company.new(name: 'Empresa B', users_attributes: [ b_owner ])

a_company.save
b_company.save

puts '==== creating Users data ===='
a_users = [
  { name: 'a1', email: 'a1@a.com' },
  { name: 'a2', email: 'a2@a.com' },
  { name: 'a3', email: 'a3@a.com' },
  { name: 'a4', email: 'a4@a.com' },
  { name: 'a5', email: 'a5@a.com' },
  { name: 'a6', email: 'a6@a.com' },
  { name: 'a7', email: 'a7@a.com' },
  { name: 'a8', email: 'a8@a.com' },
  { name: 'a9', email: 'a9@a.com' },
  { name: 'a10', email: 'a10@a.com' },
  { name: 'a11', email: 'a11@a.com' },
  { name: 'a12', email: 'a12@a.com' },
  { name: 'a13', email: 'a13@a.com' }
]

b_users = [
  { name: 'b1', email: 'b1@b.com' },
  { name: 'b2', email: 'b2@b.com' },
  { name: 'b3', email: 'b3@b.com' },
  { name: 'b4', email: 'b4@b.com' },
  { name: 'b5', email: 'b5@b.com' },
  { name: 'b6', email: 'b6@b.com' },
  { name: 'b7', email: 'b7@b.com' }
]

puts '==== creating Users to companies ===='
a_company.users.create(a_users)
b_company.users.create(b_users)

puts '==== Seeds end ===='

company_a = Company.first
own_a = company_a.users.find_by(level: 0)

u1 = company_a.users.where(name: 'a1')[0]
u2 = company_a.users.where(name: 'a2')[0]
u3 = company_a.users.where(name: 'a3')[0]
u4 = company_a.users.where(name: 'a4')[0]
u5 = company_a.users.where(name: 'a5')[0]
u6 = company_a.users.where(name: 'a6')[0]
u7 = company_a.users.where(name: 'a7')[0]
u8 = company_a.users.where(name: 'a8')[0]
u9 = company_a.users.where(name: 'a9')[0]
u10 = company_a.users.where(name: 'a10')[0]
u11 = company_a.users.where(name: 'a11')[0]
u12 = company_a.users.where(name: 'a12')[0]
u13 = company_a.users.where(name: 'a13')[0]

Users::JoinsLeaderService.call(user: u1, leader: own_a)
Users::JoinsLeaderService.call(user: u2, leader: u1)
Users::JoinsLeaderService.call(user: u3, leader: u1)
Users::JoinsLeaderService.call(user: u4, leader: u3)


Users::JoinsLeaderService.call(user: u5, leader: u1)
Users::JoinsLeaderService.call(user: u6, leader: u5)
Users::JoinsLeaderService.call(user: u7, leader: u5)

Users::JoinsLeaderService.call(user: u8, leader: own_a)
Users::JoinsLeaderService.call(user: u9, leader: u8)
Users::JoinsLeaderService.call(user: u10, leader: u9)
Users::JoinsLeaderService.call(user: u11, leader: u10)
Users::JoinsLeaderService.call(user: u12, leader: u10)
Users::JoinsLeaderService.call(user: u13, leader: u10)

