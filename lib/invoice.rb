class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes, repository)
    @repository = repository
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = day_created(attributes[:created_at])
    @updated_at = attributes[:updated_at]
  end

  def day_created(created_at)
    Date.parse(created_at).strftime("%A")
  end

  def update_time(time)
    @updated_at = time
  end

  def change_status(change)
    @status = change
  end

  def merchant
    @repository.find_all_invoices_by_merchant_id(@merchant_id)
  end
end
