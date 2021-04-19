require 'csv'
require_relative 'repository'
require_relative 'invoice'
require 'time'

class InvoiceRepository < Repository
  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_invoices
  end

  def all_invoices
    @csv_array = []
    CSV.parse(File.read(@location_hash[:invoices]), headers: true).each do |invoice|
      @csv_array << Invoice.new(
        id: invoice[0],
        customer_id: invoice[1],
        merchant_id: invoice[2],
        status:      invoice[3],
        created_at:  Time.parse(invoice[4]),
        updated_at:  Time.parse(invoice[5]),
        repository:  self
      )
    end
  end

  def find_all_by_customer_id(customer_id)
    @csv_array.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @csv_array.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @csv_array.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(invoice_hash)
    attributes = {
      id: max_id_number_new,
      customer_id: invoice_hash[:customer_id].to_i,
      merchant_id: invoice_hash[:merchant_id].to_i,
      status: invoice_hash[:status].to_sym,
      created_at: Time.now,
      updated_at: Time.now,
      repository: self
    }
    @csv_array << Invoice.new(attributes)
    Invoice.new(attributes)
  end

  def update(id, attribute)
    update_instance = find_by_id(id)
    unless update_instance.nil?
      update_instance.status = attribute[:status].to_sym unless attribute[:status].nil?
      update_instance.updated_at = Time.now
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
    # should this be @merchants or @invoices
    # same with item repo
  end
end
