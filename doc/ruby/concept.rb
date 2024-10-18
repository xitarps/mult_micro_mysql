class User
  @@data_set = []
  attr_accessor :name, :lider_id, :id, :level

  def initialize(name)
    @name = name
    @lider_id = nil
    @level = @@data_set.empty? ? 0 : nil

    @id = @@data_set.size + 1
    @@data_set << self
  end
end

class Hierarchy
  @@data = {  }

  def self.lead(user: nil, lider: nil)
    @@data = { 0 => {lider.id => lider } } if @@data.empty?
    return if user.level && user.level <= lider.level.to_i

    if user.level
      @@data[user.level].delete(user.id)
    end

    user.level = lider.level + 1
    user.lider_id = lider.id
    @@data[lider.level + 1] = {} if @@data[lider.level + 1].nil?
    @@data[lider.level + 1][user.id] = user
  end

  def self.data
    @@data
  end
end

u1 = User.new('x1')
u2 = User.new('x2')
u3 = User.new('x3')
u4 = User.new('x4')
u5 = User.new('x5')

Dictionary.lead(user: u2, lider: u1)
Dictionary.lead(user: u3, lider: u1)
binding.irb
puts 'a'
