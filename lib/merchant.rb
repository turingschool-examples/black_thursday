require 'simplecov'
SimpleCov.start

class Merchant
  attr_reader :merchant_info

  def initialize(merchant_info)
    @merchant_info = merchant_info
  end

  def name
    merchant_info[:name]
  end

  def id
    merchant_info[:id]
  end

end
