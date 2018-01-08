require "time"

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repo

  def initialize(row, merchant_repo)
    @id            = row[:id]
    @name          = row[:name]
    @created_at    = Time.parse(row[:created_at])
    @updated_at    = Time.parse(row[:updated_at])
    @merchant_repo = merchant_repo
  end

  def items
    merchant_repo.find_items(self.id)
  end

  def invoices
    merchant_repo.find_invoices_by_merchant_id(self.id)
  end

  def customers
     invoices.map do |invoice|
       merchant_repo.find_customer_by_customer_id(invoice.customer_id)
     end.uniq
  end
end
