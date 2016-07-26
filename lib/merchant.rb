class Merchant

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = Time.strptime(row[:created_at], "%Y-%m-%d")
    @updated_at = Time.strptime(row[:updated_at], "%Y-%m-%d")
  end

end
