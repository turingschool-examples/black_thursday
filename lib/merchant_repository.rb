require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader   :contents,
                :merchants,
                :parent

  def initialize(path, parent=nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @merchants = contents.map do |line|
      Merchant.new(line)
    @parent = parent
    end
  end

  def all
    @merchants
  end

  def id(id_number)
    @merchants.find do |merchant|
      if merchant.id == id_number
      merchant
      end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      if merchant.name.downcase == name.downcase
        merchant
      end
    end
  end


  def find_all_by_name(partial_search)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(partial_search.downcase)
      merchant
      end
  end
end

end
