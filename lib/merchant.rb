require 'time'

class Merchant
  attr_reader :merchant, :merchant_repo, :id, :name, :created_at, :updated_at

  def initialize(merchant, merchant_repo)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = Time.parse(merchant[:created_at])
    @updated_at = Time.parse(merchant[:updated_at])
    @merchant_repo = merchant_repo
  end

  def items
    merchant_repo.merch_items(self.id)
  end

  def invoices
    merchant_repo.merch_invoices(self.id)
  end

  def customers
    merchant_repo.merchant_customer(self.id)
  end
end
