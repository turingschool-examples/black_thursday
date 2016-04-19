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
    @merchant_date[1]
  end

  def created_at
  end

  def updated_at
  end

end
