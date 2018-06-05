require 'date'
require 'time'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

  def update_name(new_name)
    @name = new_name
    @updated_at = Time.parse(Date.today.to_s)
  end
end
