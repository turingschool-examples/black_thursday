require 'time'

class Merchant
  attr_reader :merchant, :id, :name, :created_at, :updated_at

  def initialize(merchant)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = Time.parse(merchant[:created_at])
    @updated_at = Time.parse(merchant[:updated_at])
  end
end
