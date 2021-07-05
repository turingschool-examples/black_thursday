require_relative "merchant_repository"
class Merchant

  attr_reader 

  attr_accessor :name, :id

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
  end

end
