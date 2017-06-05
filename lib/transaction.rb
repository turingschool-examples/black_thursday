class Transaction
  def initialize(data_files)
    @id = data_files[:id]
    @invoice_id = data_files[:invoice_id]
    @credit_card_number = data_files[:credit_card_number]
  end
end
