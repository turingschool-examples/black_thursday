# customer class
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
    @parent     = parent
  end

  def invoices
    @parent.pass_customer_id_to_se(@id)
  end

  def merchants
    merchant_ids = invoices.map(&:merchant_id)
    merchant_ids.map do |merchant_id|
      @parent.pass_merchant_id_to_se(merchant_id)
    end
  end

  def fully_paid_invoices
    invoices.find_all(&:is_paid_in_full?)
  end
end
