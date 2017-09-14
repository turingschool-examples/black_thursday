class Merchant
  attr_reader :merchant, :merchant_repo
  def initialize(merchant,repo = nil)
    @merchant = merchant
    @merchant_repo = repo
  end

  def id
    merchant.fetch(:id).to_i
  end

  def name
    merchant.fetch(:name)
  end

  def items
    merchant_repo.merchant_items(self.id)
  end

end
