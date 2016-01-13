require 'pry'

class Merchant
  attr_accessor :id, :name

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
  end

end
