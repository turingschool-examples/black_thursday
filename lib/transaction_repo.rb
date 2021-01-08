require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/module'
require './lib/transaction'

class TransactionRepo
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Transaction.new(data, self)
      end
      items
    end

    def test_find_all_by_credit_card_number(credit_card_number)
      all.values.find_all do |value|
        value.credit_card_number == credit_card_number
      end
    end

    def find_all_by_result (result)
      all.values.find_all do |value|
        value.result == result
      end
    end

    def create(attributes)
      @collections[attributes[:id]] = Transaction.new({
      :id                           => new_id,
      :invoice_id                   => attributes[:invoice_id ],
      :credit_card_number           =>   attributes[:credit_card_number],
      :credit_card_expiration_date  => attributes[:credit_card_expiration_date],
      :result                       => attributes[:result],
      :created_at                   => attributes[:created_at],
      :updated_at                   => attributes[:updated_at]}, self)
    end
end
