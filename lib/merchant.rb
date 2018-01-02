class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(row, parent)
    @id            = row[:id]
    @name          = row[:name]
    @created_at    = Time.parse(row[:created_at])
    @updated_at    = Time.parse(row[:updated_at])
    @merchant_repo = parent
  end
end
