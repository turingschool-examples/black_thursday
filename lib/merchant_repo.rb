require './lib/merchant'
require 'csv'

class MerchantRepository
  attr_reader :merchant_csv, :merchant_queue

  def initialize
    @merchant_csv = CSV.open './data/merchants.csv',
                    headers: true, header_converters: :symbol
    @merchant_queue = []
    @merchant_csv.map do |row|
      @merchant_queue << Merchant.new(row)
      end
  end

  def all
    @merchant_queue
    #returns an array of all known Merchant instances
  end

  def find_by_id(id)
    #returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)
    #returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name(name)
    #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

end
