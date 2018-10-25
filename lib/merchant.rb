require_relative 'business_data'

class Merchant < BusinessData
  attr_reader :id
  attr_accessor :name, :updated_at
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
  end
end
