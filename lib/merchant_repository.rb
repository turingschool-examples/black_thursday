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

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end