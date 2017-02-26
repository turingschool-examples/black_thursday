class Invoice

  attr_reader :invoice_hash, :repository

  def initialize(hash, repository = '')
    @invoice_hash = hash
    @repository = repository
  end

  def id
    invoice_hash[:id]
  end

  def customer_id
    invoice_hash[:customer_id]
  end

  def merchant_id
    invoice_hash[:merchant_id]
  end

  def status
    invoice_hash[:status]
  end

  def created_at
    invoice_hash[:created_at]
  end

  def updated_at
    invoice_hash[:updated_at]
  end

  def merchant
    repository.engine.merchants.find_by_id(merchant_id)
  end

  def day_created
    day = created_at.wday
    case day
      when 0 then 'Sunday'
      when 1 then 'Monday'
      when 2 then 'Tuesday'
      when 3 then 'Wednesday'
      when 4 then 'Thursday'
      when 5 then 'Friday'
      when 6 then 'Saturday'
    end
  end

  def items
    invoice_items.map! do |invoice_item|
      invoice_item.item
    end
  end

  def invoice_items
    repository.engine.invoice_items.find_all_by_invoice_id(id)
  end
end
