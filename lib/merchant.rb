require_relative 'sanitize'

class Merchant
include Sanitize
  attr_reader :id, :name, :created_at

  def initialize(args)
    @id = args[:id].to_i
    @name = args[:name]
    @created_at = to_time(args[:created_at])
  end

  def update(attributes)
    @name = attributes[:name]
  end
end
