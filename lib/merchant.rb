require_relative 'merchant_repo'

class Merchant

  attr_reader :merchant_info

  def initialize(merchant_info)
    @merchant_info = {}
  end


  def id
    @merchant_info[:id]
    # returns the integer id of the merchant
  end

  def name
    # returns the name of the mercha
    @merchant_info[:name]
  end




end
