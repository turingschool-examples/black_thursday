require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchant_csv, :merchant_queue, :sales_engine

  def initialize(parent)
    @merchant_csv   = CSV.open './data/merchants.csv',
                    headers: true, header_converters: :symbol
    @merchant_queue = []
    @sales_engine   = parent
    @merchant_csv.map do |row|
      @merchant_queue << Merchant.new(row)
    end
  end

  def all
    #returns an array of all known Merchant instances
    @merchant_queue
  end

  def find_by_id(id)
    #returns either nil or an instance of Merchant with a matching ID
    parse_queue("id", id)
  end

  def find_by_name(name)
    #returns either nil or an instance of Merchant having done a case insensitive search
    parse_queue_words("name", name)
  end

  def find_all_by_name(name)
    #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    parse_queue_partial_words("name", name)
  end

  def parse_queue_num(column_name, criteria)
    results = []
    @merchant_queue.map do |row|
      next if row[column_name] != criteria
      results << row.to_h
    end
  end

  def parse_queue_words(column_name, criteria)
    results = []
    @merchant_queue.map do |row|
      next if row[column_name].downcase != criteria.downcase
      results << row.to_h
    end
  end

  def parse_queue_partial_words(column_name, criteria)
    results = []
    @merchant_queue.map do |row|
      next if row[column_name].downcase.include?(criteria.downcase) == false
      results << row.to_h
    end
  end

end
