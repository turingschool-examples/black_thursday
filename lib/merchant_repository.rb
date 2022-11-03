require_relative 'find'
require_relative 'modify'
require_relative 'merchant'

class MerchantRepository
  include Find
  include Modify

  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def add(merchant)
    @merchants << Merchant.new(merchant)
  end

  def all
    @merchants
  end

  def find_by_name(name)
    find_by_name_overall(@merchants, name)
  end

  def find_by_id(id)
    find_by_id_overall(@merchants, id)
  end

  def find_all_by_name(name)
    find_all_by_name_overall(@merchants, name)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end