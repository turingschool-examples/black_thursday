require 'pry'
require 'csv'
require './lib/merchant'

class MerchantRepository

  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine = engine
    @contents = load_merchants(csvfile)
  end

  def load_merchants(csvfile)
    # change the variable name
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_merchants = {}
    contents.each do |row|
      all_merchants[row[0]] = Merchant.new({:id => row[0], :name => row[1]}, self)
    end
    all_merchants
  end

  def all
  # returns an array of all known Merchant instances
    @contents.values
  end

  def find_by_id(id)
    @contents[id.to_s]
  # returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    content_array = all
    content_array.find do |merchant|
      if merchant.name == name
        return merchant
      end
    end
  # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
  # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    content_array = all
    content_array.find_all do |merchant|
      if merchant.name.start_with?(name)
        merchant
      end
    end
  end

end
