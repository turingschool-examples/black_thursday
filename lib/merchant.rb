require 'csv'

class Merchant
  attr_reader :id, :name

  def initialize(merch_hash)
    @id = merch_hash[:id].to_i
    @name = merch_hash[:name].to_s
  end



end
