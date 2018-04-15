require 'csv'
require_relative 'transaction'
require_relative 'repository'

# This class is a repo for transactions
class TransactionRepository
  include Repository
  def initialize(engine = nil)
    @engine = engine
    @elements = {}
    @invoice_ids = Hash.new{ |h, k| h[k] = [] }

  end

  def build_elements_hash(elements)
    elements.each do |element|
      transaction = Transaction.new(element, @engine)
      @elements[transaction.id] = transaction
      @invoice_ids[transaction.invoice_id] << transaction
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |element|
      element.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |element|
      element.result == result
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    transaction = Transaction.new(attributes, @engine)
    @elements[create_id_number] = transaction
  end
end
