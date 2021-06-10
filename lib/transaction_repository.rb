require_relative 'inspectable'

class TransactionRepository
  include Inspectable

  attr_reader :file_path,
              :sales_engine,
              :all

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return nil if transaction.nil?

    transaction.update_transaction(attributes)
  end

  def delete(id)
    deleted_invoice_item = find_by_id(id)
    @all.delete(deleted_invoice_item)
  end
end
