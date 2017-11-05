require_relative "merchant"
require "csv"

class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(merchant_file, sales_engine)
    @merchants = []
    merchants_from_csv(merchant_file)
    @sales_engine = sales_engine
  end

  def merchants_from_csv(merchant_file)
    CSV.foreach(merchant_file, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row, self)
    end
    @merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def merch_items(merchant_id)
    sales_engine.find_merchant_items(merchant_id)
  end

  def merch_invoices(invoice_id)
    sales_engine.find_merchant_invoices(invoice_id)
  end

  def inspect
    "#{self.class} #{merchants.size} rows"
  end

end
