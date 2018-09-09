require 'date'

class Merchant
  attr_accessor :id, :name
  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @created_at = (Date.today).to_s
  end
end
