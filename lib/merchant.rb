class Merchant
  attr_reader :id, :created_at, :updated_at

  attr_accessor :name

  def initialize(information)
    @id = information[:id]
    @name = information[:name]
    @created_at ||= information[:created_at]
    @updated_at ||= information [:updated_at]
  end
end
