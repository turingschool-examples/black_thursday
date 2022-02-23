#require_relative 'merchant.rb'

class MerchantRepository

attr_reader :all
  def initialize(merchants)
    @all = merchants
  end

end
