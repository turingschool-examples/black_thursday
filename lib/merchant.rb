require 'pry'

class Merchant

  attr_reader :id, :name
  
  def initialize (merchant_hash = {})
    @id = merchant_hash.values[0]
    @name = merchant_hash.values[1]
  end

end