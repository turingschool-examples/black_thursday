# frozen_string_literal: true

# Merchant class
class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at].to_s
    @updated_at = attributes[:updated_at].to_s
  end
end
