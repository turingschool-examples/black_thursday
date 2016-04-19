require "csv"
require "merchant"

class MerchantRepo
  def intialize
    @all_merchants = Array.new
  end

  def merchants
    contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol

    @all_merchants = contents.map do |row|
      Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end


  def all
    merchants
  end

  def find_by_id(id)
    @all_merchants.find { |merchant| merchants.id == id }
  end


end
