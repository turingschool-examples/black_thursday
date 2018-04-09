require_relative 'findable'

# merchant class
class Merchant
  include Findable
  # attr_reader :id
  # attr_accessor :name

  def initialize(merchant_hash = Hash.new(0))
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end
end
