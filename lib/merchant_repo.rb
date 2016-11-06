require_relative './merchant'
require_relative './item'
require_relative './data_parser'

class MerchantRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all = parse_data(file).map { |row| Merchant.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase.eql?(name.downcase)}
  end

  def find_all_by_name(name_fragment)
    @all.find_all {|merchant| merchant.name.downcase.include?(name_fragment)}
  end

  def find_items_by_merchant_id(id)
    @parent.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    @parent.find_invoices_by_merchant_id(id)
  end

  def find_invoice_items_by_merchant_id(id)
    @parent.find_invoice_items_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
