class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id =           data[:id].to_i
    @customer_id =  data[:customer_id].to_i
    @merchant_id =  data[:merchant_id].to_i
    @status =       data[:status].to_sym
    @created_at =   prep_time(data[:created_at])
    @updated_at =   prep_time(data[:updated_at])
    @parent     =   parent
  end

  def prep_time(time)
    return nil if !time
    Time.parse(time)
  end

  def merchant
    @parent.find_merchant_by_id(@merchant_id)
  end

  def items
    @parent.find_items_by_id(@id)
  end

  def transactions
    @parent.find_transactions_by_id(@id)
  end

  def customer
    @parent.find_customer_by_id(@customer_id)
  end

  def weekday_created
    created_at.strftime("%A")
  end
end
