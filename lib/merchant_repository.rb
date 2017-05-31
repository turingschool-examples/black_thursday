require 'csv'

class MerchantRepository

  attr_reader :all_merchant_data

  def initialize
    @all_merchant_data = CSV.open("./data/merchants.csv",
    headers: true, header_converters: :symbol).map do |row|
      row
    end
  end

  def all
    @all_merchant_data
  end

  def find_by_id
    merchant_by_id = @all_merchant_data.map do |num|
      num
    end
  end

  def find_by_name

  end

  def find_all_by_name

  end

end

merchant = MerchantRepository.new
