require 'csv'
require 'time'
require 'date'
require_relative 'merchant'

class MerchantRepository

  attr_reader :path,
              :merchants,
              :sales_engine

  def initialize(path, sales_engine)
    @merchants ||= []
    @path = path
    @sales_engine ||= sales_engine
    load_path(path)
  end

  def all
    @merchants
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id.to_i
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create_new_id
    @merchants.map do |merchant|
      merchant.id
    end.max + 1
  end

  def create(attribute)
    attribute[:id] = create_new_id
    attribute[:created_at] = Time.now
    attribute[:updated_at] = Time.now
    @merchants << Merchant.new(attribute, self)
  end

  def update(id, attribute)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.change_update_time
    to_update.change_name(attribute[:name]) if attribute[:name]
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def invoices_for_merchant(id)
    sales_engine.invoices_for_merchant(id)
  end

  def items_for_a_merchant(merchant_id)
    sales_engine.items_for_a_merchant(merchant_id)
  end

  def find_customers_for_a_merchant(customer_id)
    sales_engine.find_customers_for_a_merchant(customer_id)
  end
end
