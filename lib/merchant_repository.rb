# require './data/merchants.csv'
require 'csv'

class MerchantRepository

  attr_reader     :all,
                  :parent

  def initialize(parent = nil)
    @all = []
    @parent = parent
  end

  def populate(filename)
    contents = CSV.open(filename, headers: true,
     header_converters: :symbol)

    contents.each do |row|
      @all << Merchant.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id.to_i == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    parent.find_all_by_merchant_id(merchant_id)
  end

end
