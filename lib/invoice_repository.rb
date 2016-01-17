require_relative 'invoice'
require          'pry'

class InvoiceRepository
  

  def initialize(csv_hash)
    @invoice_instances = csv_hash.map do |csv_hash|
      merchant = Item.new(csv_hash)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all

  end

  def find_by_id

  end

  def find_all_by_customer_id

  end

  def find_all_by_merchant_id

  end

  def find_all_by_status

  end

end
