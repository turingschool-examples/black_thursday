class Merchant
  attr_reader :id, :name

  def initialize(line_of_merchant, parent)
    @id = line_of_merchant.fetch(:id)
    @name = line_of_merchant.fetch(:name)
    @merchant_repo = parent
  end

end
