class InvoiceRepository
  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoices(path)
  end

  def create_invoices(path)
    invoices = CSV.foreach(path, headers: true, header_converters: :symbol) do |invoice_data|
      data_hash = {
                    id: invoice_data[:id],
                    status: invoice_data[:status],
                    customer_id: invoice_data[:customer_id].to_i,
                    merchant_id: invoice_data[:merchant_id].to_i,
                    created_at: Time.parse(invoice_data[:created_at]),
                    updated_at: Time.parse(invoice_data[:updated_at])
                  }
      @all << Invoice.new(data_hash)
    end
  end
end
