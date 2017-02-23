require 'csv'
require 'pry'
require_relative '../lib/merchant'

class MerchantRepository
  attr_reader :all
  def initialize(path)
    # @path = path
    @all = []
    csv_loader(path)
    merchant_maker
  end


  def csv_loader(path)
    @csv = CSV.open(path, headers:true, header_converters: :symbol)
  end

  def merchant_maker
    @all = @csv.map do |row|
      Merchant.new(row, self)
    end
    # binding.pry
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name == name
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id.to_i == id.to_i
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |merchant|
      merchant.include?(name_fragment)
    end
  end

end


---------------------------------

  def all
    # returns an array of all known Merchant instances
  end

  def find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end
end
