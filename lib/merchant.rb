require 'pry'

class Merchant

  attr_reader :id, :name

  def initialize (parent, merchant_hash = {})
    @id = merchant_hash.values[0]
    @name = merchant_hash.values[1]
    @parent = parent
  end

end
