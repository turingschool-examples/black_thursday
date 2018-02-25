require 'bigdecimal'
require 'time'
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @parent = parent
  end

  # def merchant
  #   @parent.item_repo_goes_to_sales_engine_with_merchant_id(self.merchant_id)
  # end
end
