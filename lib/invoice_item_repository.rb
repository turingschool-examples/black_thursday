require_relative 'repository_assistant'

class InvoiceItemsRepository
  include RepositoryAssistant

end

def inspect
  "#<#{self.class} #{@invoice_items.size} rows>"
end
