class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(csv_data)
    @id = csv_data[:id]
    @name = csv_data[:name]
    @created_at = csv_data[:created_at]
    @updated_at = csv_data[:updated_at]
  end
end
