require './lib/merchant'
require './lib/sales_engine'
require_relative 'find'
require 'pry'

class MerchantRepository
  include Find

  attr_accessor :merchants

  def initialize
    @merchants = []
  end

  def <<(merch_obj)
    @merchants.push(merch_obj)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_by_name(name)
    find_by_string({:name => name})
  end

  def find_all_by_name(partial)
    find_all_by_string_fragment({:name => partial})
  end

end
