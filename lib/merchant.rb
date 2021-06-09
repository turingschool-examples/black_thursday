require_relative '../lib/modules/timeable'

class Merchant
  include Timeable

  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    @id          = data[:id].to_i
    @name        = data[:name]
    @created_at  = update_time(data[:created_at].to_s)
    @updated_at  = update_time(data[:updated_at].to_s)
  end

  def update(attributes)
    @name        = attributes[:name]
    @updated_at  = update_time('')
  end
end
