require 'pry'
class Merchant
  attr_reader :id, :name, :engine

  def initialize(info = {}, merchant_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @engine = engine
  end
end
