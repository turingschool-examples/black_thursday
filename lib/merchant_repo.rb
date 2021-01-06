require 'csv'

class MerchantRepo
  attr_reader :merchant_list

  def initialize(input)
    make_merchants(input)
  end

  def make_merchants(input)
    merchants = CSV.open(input, headers: true,
    header_converters: :symbol)

    @merchant_list = merchants.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    merchant_list
  end

  def find_by_id(id)
    if id.nil?
      nil
    else
       @merchant_list.find do |merchant|
        merchant.id == id
      end
    end
  end

  def find_by_name(name)
    if name.nil?
      nil
    else
       @merchant_list.find do |merchant|
        merchant.name.downcase == name.downcase
      end
    end
  end
end
