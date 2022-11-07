require_relative 'repository'

class TransactionRepository < Repository
  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |item|
      item.invoice_id == invoice_id
    end
  end
end