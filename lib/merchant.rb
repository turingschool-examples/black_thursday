require 'pry'

class Merchant
  attr_reader :id,
              :name

  def initialize(data_hash)
    @id   = data_hash[:id].to_i
    @name = data_hash[:name]
  end
end
