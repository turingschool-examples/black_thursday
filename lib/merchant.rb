class Merchant
  attr_reader :id, :name

  def initialize(row, parent=nil)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent = parent
  end
end
