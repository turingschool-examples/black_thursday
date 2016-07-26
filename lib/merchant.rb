class Merchant

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

end
