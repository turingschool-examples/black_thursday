class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id =   data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = prep_time(data[:created_at])
    @updated_at = prep_time(data[:updated_at])
    @parent = parent
  end

  def prep_time(time)
    return nil if !time
    Time.parse(time)
  end

  def merchants
    merchants = @parent.find_all_merchants_by_id(@id)
  end

  def fully_paid_invoices
    @parent.find_fully_paid_invoices_by_customer_id(@id)
  end

  def invoices
    @parent.find_invoices_by_customer_id(@id)
  end

end
