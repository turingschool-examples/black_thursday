require './test/helper'

class Merchant
  attr_reader     :id
  attr_accessor   :name

  def initialize(data_hash)
    @id   = data_hash[:id].to_i
    @name = data_hash[:name]
  end

end
