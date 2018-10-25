require_relative 'business_data'

class Merchant < BusinessData
  attr_reader :id
  attr_accessor :name, :updated_at, :created_at
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
