require_relative "merchant"

class MerchantRepository
  attr_reader :merchant_repository

  def initialize(merchant_csv, parent)
    @merchant_csv = merchant_csv
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@merchant_repository.size} rows>"
  end

  def make_merchant_repository
    @merchant_repository = {}
    @merchant_csv.read.each do |merchant|
      @merchant_repository[merchant[:merchant_id]] = Merchant.new(merchant, self)
    end
    return self
  end

  #The MerchantRepository is responsible for holding and searching our Merchant instances. It offers the following methods:

  def all #- returns an array of all known Merchant instances
    @merchant_repository.map do |key, value|
      value 
  end

  def find_by_id #- returns either nil or an instance of Merchant with a matching ID

  end

  def find_by_name #- returns either nil or an instance of Merchant having done a case insensitive search

  end

  def find_all_by_name #- returns either [] or one or more matches which contain the supplied name fragment, case insensitive

  end

end
