# require './merchantrepository'
require 'csv'
class Merchant
  # include MerchantRepository
  attr_reader :id,
              :name,
              :merchants
  @@filename = './data/sample.csv'



  def initialize(info)
    @id = info[:id]
    @name = info[:name]
  end

  def self.find_by_id(id)
    rows = CSV.read(@@filename, headers: true)
    rows.by_row

    csv_2_hash = rows.map do |row|
      row = row.to_hash
    end
    
    id_1 = rows["id"]

    merchants = []
    csv_2_hash.find do |merchant|
      if id_1 == id
        merchants << merchant
      end
      merchants
    end
  end
end
