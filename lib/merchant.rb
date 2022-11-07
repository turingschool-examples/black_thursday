require_relative 'require_store'

class Merchant
  attr_accessor :id,
              :name,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id   = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end
end