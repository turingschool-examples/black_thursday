require 'CSV'
class Merchant < MerchantRepository
  attr_reader :id, :name

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
  end

end
