require_relative 'searching'
require_relative 'merchant'

# Creates and manages merchant repository
class MerchantRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_engine)
    @all = from_csv(file_path)
    @sales_engine = sales_engine
  end

  def add_elements(data)
    data.map { |row| Merchant.new(row, self) }
  end

  def find_all_by_name(fragment)
    @all.find_all do |obj|
      obj.name.upcase.include?(fragment.upcase)
    end
  end

  def items(id)
    @sales_engine.find_merchant_items(id)
  end

  def invoices(id)
    @sales_engine.find_merchant_invoices(id)
  end

  def customers(id)
    @sales_engine.find_merchant_customers(id)
  end

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
