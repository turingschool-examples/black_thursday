require_relative 'merchant_repository'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader :contents

  def self.from_csv(hash_of_csv_files)
    @csv_files = {}
    hash_of_csv_files.each do |key, value|
      csv_file_object = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file_object
    end

  end

  def self.merchants
    mr = MerchantRepository.new(@csv_files[:merchants])
  end

  def self.items
  end

end

if __FILE__ == $0
# se = SalesEngine.new
# se.from_csv({:merchants => './data/merchants.csv',
#              :items => './data/items.csv'})

se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
mr = SalesEngine.merchants
# all = mr.all
# puts all
# puts mr.find_by_name("CJsDecor")

end
