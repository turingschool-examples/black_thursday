require_relative 'invoice'

class InvoiceRepository
  def initialize(loaded_file)
    @invoice_repo = loaded_file.map { |invoice| Invoice.new(invoice)}
  end

  def all
    @invoice_repo
  end

  def find_by_id(id)
    all.find {|invoice| invoice.id == id}
  end

  def inspect
   "#{self.class} #{@invoice_repo.size} rows"
  end
end
