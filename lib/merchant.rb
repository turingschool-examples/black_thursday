require 'csv'
class Merchant
  attr_reader :id, :name, :array_of_hashes
  def initialize(merchant_info)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
    @array_of_hashes = []
  end

  def collection_of_merchants
  # accesses csv file
    info = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
    info_hash = {}
    info.each do |row|
  # iterates throughthe csv file and takes the ID and Name
      id = row[:id]
      name = row[:name]
  # stores ID and NAme into hash
      info_hash[:id] = id.to_i
      info_hash[:name] = name
  # stores those hashes in an array of merchants
       @array_of_hashes.push(info_hash)
      # require 'pry';binding.pry
    end
    @array_of_hashes
  end
end

# class method
# self.merchants_collection(merchants)
# merchants.map do |merchant|
# Merchant.new(merchant[:id], merchant[:name])
# end end end
