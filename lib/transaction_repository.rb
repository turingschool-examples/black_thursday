require_relative 'sales_engine'
require_relative 'transaction'
require_relative 'mathable'

class TransactionRepository
  include Mathable
  attr_reader :transactions

  def initialize(path, engine)
    @transactions = []
    @engine = engine
    make_transactions(path)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def make_transactions(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@transactions)
    attributes[:created_at] = attributes[:created_at].to_s
    attributes[:updated_at] = attributes[:created_at].to_s
    @transactions << Transaction.new(attributes, self)
  end

  def delete(id)
    transactions.delete(find_by_id(id))
  end

  def find_all_by_credit_card_number(credit_card_number)
    RepoBrain.find_all_by_id(credit_card_number,
                             'credit_card_number',
                             @transactions)
  end

  def find_all_by_invoice_id(invoice_id)
    RepoBrain.find_all_by_id(invoice_id, 'invoice_id', @transactions)
  end

  def find_all_by_result(result)
    RepoBrain.find_all_by_id(result, 'result', @transactions)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @transactions)
  end

  def invoice_paid_in_full?(invoice_id)
    @transactions.each_with_object([]) do |transaction, array|
      if transaction.invoice_id == invoice_id
        array << transaction.result
      end
    end.include?(:success)
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      invoice_to_update = find_by_id(id)
      invoice_to_update.update(attributes)
    end
  end
end
