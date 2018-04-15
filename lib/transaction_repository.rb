require'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions,
              :path,
              :sales_engine

  def initialize(path, sales_engine)
    @path = path
    @sales_engine ||= sales_engine
    @transactions ||= []
    load_path(path)
  end

  def all
    @transactions
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @transactions << Transaction.new(data, self)
    end
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def create_new_id
    @transactions.map do |transaction|
      transaction.id
    end.max + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.strftime('%F')
    attributes[:updated_at] = Time.now.strftime('%F')
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.update_updated_at
    to_update.update_credit_card_number(attributes[:credit_card_number]) if attributes[:credit_card_number]
    to_update.update_credit_card_expiration_date(attributes[:credit_card_expiration_date]) if attributes[:credit_card_expiration_date]
    to_update.update_result(attributes[:result]) if attributes[:result]
  end

  def delete(id)
    @transactions.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
