require './lib/merchant'
require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :merchant_csv,
              :merchants,
              :sales_engine

  def initialize(parent)
    @merchants      = []
    @sales_engine   = parent
    @load           = load_file
    end
  end

  def load_file
    merchant_csv   = CSV.open './data/merchants.csv',
                    headers: true, header_converters: :symbol
    merchant_csv.map do |row|
      @merchants << Merchant.new(row, self)
  end

  def all
    #returns an array of all known Merchant instances
    @merchants
  end

  def find_by_id(id)
    #returns either nil or an instance of Merchant with a matching ID
      @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    #returns either nil or an instance of Merchant having done a case insensitive search
      @merchants.find { |merhcant| merhcant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    parse_queue_partial_words("name", name)
  end

  def parse_queue_partial_words(column_name, criteria)
    results = []
    @merchants.map do |row|
      next if row.name.include?(criteria) == false
      results << row
    end
    results
  end

end
