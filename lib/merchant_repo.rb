require 'pry'
require 'csv'
require './lib/merchant'

class MerchantRepository
  # The MerchantRepository is responsible for holding and searching our Merchant instances.
  # sales engine will be passed through each repo

  attr_reader :salesengine, :contents

  def initialize(csvfile, salesengine)
    @salesengine = salesengine
    @contents = CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def all
  # returns an array of all known Merchant instances
    all_merchants = {}
    @contents.each do |row|
      all_merchants[row[0]] = Merchant.new(self, {:id => row[0], :name => row[1]})
    end
    all_merchants
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
