require_relative 'find'
require_relative 'modify'

class MerchantRepository
  include Find
  include Modify

  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def add(merchant)
    @merchants << merchant
  end
end