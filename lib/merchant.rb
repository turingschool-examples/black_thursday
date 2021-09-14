# require './merchantrepository'
require 'csv'
class Merchant
  # include MerchantRepository
  attr_reader :id,
              :name,
              :merchants
  @@filename = './data/merchants.csv'
  def initialize(info)
    @id = info[:id]
    @name = info[:name]

  end

  def self.find_by_id(id)
    rows = CSV.read(@@filename, headers: true)
    rows.by_col

    id = rows["id"]
    
    merchants = id.find do |merchant|
      merchant == rows["name"]
    end
    merchants
  end
end
