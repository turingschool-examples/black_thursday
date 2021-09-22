require 'csv'
require_relative 'transaction'
class TransactionRepository
  attr_reader :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Transaction.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |t|
      t.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @all.find_all do |t|
      t.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @all.find_all do |t|
      t.result == result

    end
  end

  def create(attributes)
    id_max = @all.max_by {|transaction| transaction.id}
    attributes[:id] = id_max.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Transaction.new(attributes)
    @all.push(new)
  end

  def update(id, attribute)

    updated_transaction = self.find_by_id(id)
      if updated_transaction != nil

        updated_transaction.result = attribute[:result]
        updated_transaction.updated_at = Time.now

      end

  end

  def delete(id)
    @all.delete_if do |row|
      row.id == id
    end
  end

  def inspect
   "#<#{self.class} #{@transaction.size} rows>"
 end
end
