# frozen_string_literal: true

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(details)
    @id = details[:id].to_i
    @name = details[:name]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def update_name(name)
    @name = name
  end
end
