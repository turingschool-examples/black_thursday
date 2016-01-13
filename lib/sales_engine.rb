require './lib/merchant_repository'
require 'pry'
require 'csv'

class SalesEngine

  def self.from_csv(hash_of_csv_files)
    # puts hash_of_csv_files.count
    # => create (.count) many arrays, named after keys
    contents = [] # map?
    hash_of_csv_files.each do |key, value|
      key = CSV.open value, headers: true, header_converters: :symbol
      contents << key
    end

    mr = MerchantRepository.new(contents)
    mr.parse_merchants
  end

end

if __FILE__ == $0
# se = SalesEngine.new
# se.from_csv({:merchants => './data/merchants.csv',
#              :items => './data/items.csv'})

se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
end
