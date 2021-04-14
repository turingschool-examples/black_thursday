require 'date'
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(row)
    @id = (row[:id]).to_i
    @name = row[:name]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
  end
end