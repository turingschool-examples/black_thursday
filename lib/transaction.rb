require 'bigdecimal'
require 'time'

class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(row, transaction_repo)
    @id = (row[:id]).to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = (row[:credit_card_number]).to_i
    @credit_card_expiration_date = Time.parse(row[:credit_card_expiration_date])
    @result = row[:result]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @transaction_repo = transaction_repo
  end

#   def update_time_stamp
#     @updated_at = Time.now
#   end

#   def day_created
#     @created_at.strftime('%A').capitalize
#   end
end
