require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'
require 'csv'


class SalesEngine
  attr_reader :opened_csv_files

  def initialize(csv_repo)
    @csv_repo = csv_repo
  end

  def self.from_csv(file_path)
    @csv_files = {}
    file_path.each do |key, value|
      csv_file_object = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file_object
    end
    SalesEngine.new(@csv_files)
  end


  def merchants
    MerchantRepository.new(@csv_repo[:merchants])
  end

  def items
    ItemRepository.new(@csv_repo[:items])
  end

end

if __FILE__ == $0

# se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                           :items => './data/items.csv'})
binding.pry
# mr = SalesEngine.merchants
mr = se.merchants
# puts mr.all
puts mr.find_by_name("Shopin1901")
# puts mr.find_by_name("jejum")
end
