class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(row, parent = nil)
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = Time.strptime(row[:created_at], "%Y-%m-%d %H:%M:%S %z")
    @updated_at = Time.strptime(row[:updated_at], "%Y-%m-%d %H:%M:%S %z")
    @parent = parent
  end

end
