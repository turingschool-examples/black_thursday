class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent


  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  # def merchants
  #   merchant_ids = parent.parent.invoices.find_all_by_merchant_id(id).map do |invoice|
  #     invoice.merchant_id
  #   end
  #   merchant_ids.map do |id|
  #     parent.parent.merchants.find_by_id(id)
  #   end
  # end


end
