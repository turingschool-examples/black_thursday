class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at
  def initialize(data, mr = nil)
    @mr   = mr
    @id   = data[:id]
    @name = data[:name]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
  end

  def items
    @mr.fetch_items(id)
  end

  def invoices
    @mr.fetch_invoices(id)
  end

  def customers
    @mr.fetch_customers_by_merchant_id(id)
  end

  def total_revenue
    invoices.reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def created_month
    month = created_at.split('-')[1].strip.to_i
    case month
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
    end
  end


end
