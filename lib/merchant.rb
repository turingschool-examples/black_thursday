class Merchant
  attr_reader :id, :name
  def initialize(id:, name:, created_at:, updated_at:)
    @id = id
    @name = name
    @created_at = DateTime.parse(created_at)
    @updated_at = DateTime.parse(updated_at)
  end
end