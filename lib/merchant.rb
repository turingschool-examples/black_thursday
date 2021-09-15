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

    id_1 = rows["id"]
    merchants = []
    rows.find do |merchant|
      # require "pry"; binding.pry
      if id_1 == id
        merchants << merchant
      end
      merchants
    end
  end
end
