require 'csv'

class Merchant
  attr_reader :id,
              :name

  def initialize(merch_hash)
    @id = merch_hash[:id]
    @name = merch_hash[:name]
  end
end
