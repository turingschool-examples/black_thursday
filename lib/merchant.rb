class Merchant
  attr_reader :merchant, :merchant_repo
  def initialize(merchant, merchant_repo)
    @merchant = merchant
    @merchant_repo = merchant_repo
  end

  def id
    merchant.fetch(:id).to_i
  end

  def name
    merchant.fetch(:name)
  end

  def created_at
    Time.parse(merchant.fetch(:created_at))
  end

  def updated_at
    Time.parse(merchant.fetch(:updated_at))
  end

  def items
    merchant_repo.merchant_items(self.id)
  end

  def invoices
    merchant_repo.merchant_invoices(self.id)
  end

  def customers
    merchant_repo.merchant_customer(self.id)
  end
end
