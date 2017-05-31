require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository

  attr_reader :merchants

  def initialize(csv)
    @merchants = {}
    self.add(csv)
  end

  def add(csv)
    csv.each do |row|
      stuff = row.to_h
      merchants[stuff[:id]] = Merchant.new(stuff)
    end
  end

  def all
    merchants.values
  end
end
#   def find_by_id(id)
#
#   end
#
#   def find_by_name
#   end
#
#   def find_all_by_name
#   end
  # csv = CSV.open('./data/merchants.csv', :headers => true, :header_converters => :symbol)
  # hel = csv.to_a.map do |row|
  #   row.to_hash
  # end
#   # binding.pry
# end



# find_by_id(id) returns either nil or an instance of Merchant with matching ID

# find_by_name(name) returns either nil or an instance of Merchant from a case insensitive search

#find_all_by_name returns either [] or one or more matches which contain the supplied name fragment, case insensitive
