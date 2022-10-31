require_relative 'find'

class MerchantRepository
  include Find

  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def add(merchant)
    @merchants << merchant
  end
end