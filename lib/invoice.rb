
class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @customer_id = datum[:customer_id].to_i
    @merchant_id = datum[:merchant_id].to_i
    @status = datum[:status].to_s.to_sym
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def merchant
    parent_repo.find_merchant(merchant_id)
  end

  def transactions
    parent_repo.find_transactions(id)
  end

  def customer
    parent_repo.find_customer(customer_id)
  end

  def items
    parent_repo.find_invoice_items(id) do |invoice_items|
      return invoice_items.map do |invoice_item|
        invoice_item.item
      end.compact.uniq
    end
  end

end
