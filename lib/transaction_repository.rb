require 'time'
require 'CSV'
require_relative "merchant"
require_relative "invoice"
require_relative "item"
require_relative '../modules/findable'
require_relative '../modules/changeable'
require_relative "transaction"

class TransactionRepository
  include Findable
  include Changeable

  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all {|invoice| invoice.invoice_id == id}
  end
end

# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status
# create(attributes) - create a new Transaction instance with the provided attributes. The new Transaction’s id should be the current highest Transaction id plus 1.
# update(id, attribute) - update the Transaction instance with the corresponding id with the provided attributes. Only the transaction’s credit_card_number, credit_card_expiration_date, and result can be updated. This method will also change the transaction’s updated_at attribute to the current time.
# delete(id) - delete the Transaction instance with the corresponding id
