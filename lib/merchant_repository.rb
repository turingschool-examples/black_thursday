require 'pry'
require './lib/findable'

class MerchantRepository
  include Findable
  attr_reader :all
  def initialize(array)
    @all = array
  end

    def find_all_by_name(name)
    @all.find_all do |one|
      one.name.downcase.include?(name.downcase)
    end
  end

  # helper method for create
  def highest_id
    last_id = 0
    @all.max do |one|
      last_id = one.id
    end
    return last_id
  end

  def create(attributes)
    attributes[:name] = Merchant.new({ :id => self.highest_id + 1, :name => attributes[:name] })
  end

  def update(id, attributes)
    new_name = self.find_by_id(id)
    new_name.name = attributes[:name]
    return new_name
  end

  def delete(id)
    erase = self.find_by_id(id)
    @all.delete(erase)
  end
end
