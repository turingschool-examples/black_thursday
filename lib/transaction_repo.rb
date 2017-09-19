class TransactionRepository
  attr_reader :trans
  
  def initialize(trans_file, sales_engine)
    @trans = read_trans_file(trans_file)
    @sales_engine = sales_engine
  end

  def read_trans_file(trans_file)
    trans_list =[]
    CSV.foreach(i_item_file, headers: true, header_converters: :symbol) do |row|
      trans_info = {}
      trans_info[:id] = row[:id]
      trans_info[:credit_card_number] = row[:credit_card_number]
      trans_info[:credit_card_expiration_date] = row[:credit_card_expiration_date]
      trans_info[:result] = row[:result]
      trans_info[:created_at] =row[:created_at]
      trans_info[:updated_at] = row[:updated_at]
      trans_list << Transaction.new(trans_info, self)
    end
    trans_list
  end

  def all
    trans
  end

  def find_by_id(id)
    trans.find { |trans| trans.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    trans.find_all {|trans| trans.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    trans.find_all do
      |trans| trans.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    trans.find_all {|trans| trans.result == result}
  end
end
