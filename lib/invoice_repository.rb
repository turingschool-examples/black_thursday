require 'time'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices, engine)
    @invoices = create_invoices(invoices)
    @engine = engine
  end

  def all
    @invoices
  end

  def find_by_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_customer_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @invoices.find_all do |invoice|
        invoice.customer_id == id
      end
    end
  end

  def a_valid_id?(id)
    @invoices.any? do |invoice| invoice.id == id
    end 
  end
  
  def a_valid_merchant_id?(id)
    @invoices.any? do |invoice| invoice.merchant_id == id
    end 
  end

  def find_all_by_merchant_id(id)
    if !a_valid_merchant_id?(id)
      return []
    else
      @invoices.find_all do |invoice|
        invoice.merchant_id == id
      end
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attribute)
    new_id = @invoices.last.id + 1
    @invoices << Invoice.new(
      {
      :id           => new_id, 
      :customer_id  => attribute[:customer_id],
      :merchant_id  => attribute[:merchant_id],
      :status       => attribute[:attribute],
      :created_at   => attribute[:created_at],
      :updated_at   => attribute[:updated_at]
      }, self)
  end

  def update(id, info)
    @invoices.each do |invoice|
      invoice.update(info) if invoice.id == id
    end
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end

  def create_invoices(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_invoice_object(contents)
  end
  
  def make_invoice_object(contents)
    contents.map do |row|
      invoice = {
              :id => row[:id].to_i, 
              :customer_id => row[:customer_id].to_i,
              :merchant_id => row[:merchant_id].to_i,
              :status => row[:status].to_sym,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      Invoice.new(invoice, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end