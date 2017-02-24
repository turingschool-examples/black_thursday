require_relative 'merchant'

class MerchantRepository
  attr_accessor :merchants
  attr_reader :merchant_repository, :merchant_csv, :se_parent

  def initialize(merchant_csv = nil, se_parent)
    @merchant_csv = merchant_csv
    @se_parent = se_parent
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
    @all_merchants = []
    @merchant_repository.each do |key, value|
      @all_merchants << value
      require "pry"; binding.pry
    end
  end

  def find_by_id(id = nil) #- returns either nil or an instance of Merchant with a matching ID
    all.find do |instance|
      instance.send(search_hash.keys[0]) == search_hash.values[0]
    end
  end

  def find_by_name #- returns either nil or an instance of Merchant having done a case insensitive search

  end

  def find_all_by_name #- returns either [] or one or more matches which contain the supplied name fragment, case insensitive

  end

  def inspect
    "#<#{self.class} #{@merchant_repository.size} rows>"
  end

end
