class Merchant
  attr_reader :id, :name

  def initialize(row, parent=nil)
    @id = row[:id]
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent = parent
  end

  # def id
  #   # returns the integer id of the merchant
  # end
  #
  # def name
  #   # returns the name of the merchant
  # end
end
