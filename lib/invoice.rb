class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at

  def initialize(invoice, invoice_repo_parent = nil)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = Time.parse(invoice[:created_at])
    @updated_at = Time.parse(invoice[:updated_at])
    @parent = invoice_repo_parent
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
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

end
