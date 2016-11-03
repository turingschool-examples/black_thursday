class Merchant
  attr_reader :name,
              :id,
              :created_at,
              :updated_at

  def initialize(row, parent = nil)
    @id         = row[:id].to_i
    @name       = row[:name].to_s
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent     = parent
  end
end
