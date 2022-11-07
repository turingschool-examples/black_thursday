require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def find_all_by_invoice_id(id)
    @repo.select { |invoice_item| invoice_item.invoice_id == id }
  end

end
