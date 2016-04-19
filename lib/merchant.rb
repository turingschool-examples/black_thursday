require 'csv'

class Merchant
  attr_accessor :merchant_data, :merchant_repository

  def initialize(merchant_data)
    @merchant_data = merchant_data
  end

  def id
    @merchant_data[0].to_i
  end

  def name
    @merchant_data[1]
  end

  def created_at
    @merchant_data[2]
  end

  def updated_at
    @merchant_data[3]
  end

end
