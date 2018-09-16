require 'csv'
require 'bigdecimal'
require 'time'


class Transaction
  attr_reader :id,
              :invoice_id,
              :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(record_stats)
    @id = record_stats[:id]
    @invoice_id = record_stats[:invoice_id]
    @credit_card_number = record_stats[:credit_card_number]
    @credit_card_expiration_date = record_stats[:credit_card_expiration_date]
    @result = record_stats[:result]
    @created_at = record_stats[:created_at]
    @updated_at = record_stats[:updated_at]
  end
end
