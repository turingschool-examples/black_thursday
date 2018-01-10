class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info, customer_repository = "")
    @id = info[:id].to_i
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = Time.strptime(info[:created_at],"%Y-%m-%d %H:%M:%S %Z")
    @updated_at = Time.strptime(info[:updated_at],"%Y-%m-%d %H:%M:%S %Z")
    @parent = customer_repository
  end

  def merchants
    @parent.find_all_merchants_by_customer_id(@id).map do |invoice|
      invoice.merchant
    end
  end
end
