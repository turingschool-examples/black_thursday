require 'pry'
require './lib/findable'
require './lib/crudable'

class MerchantRepository
  include Findable
  include Crudable
  attr_reader :all, :new_object

  def initialize(array)
    @all = array
    @new_object = Merchant
  end

  def find_all_by_name(name)
    @all.find_all do |one|
      one.name.downcase.include?(name.downcase)
    end
  end
end
