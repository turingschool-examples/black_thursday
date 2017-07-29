require_relative 'merchant'
require 'pry'

class MerchantRepository

  attr_reader :merchants,
              :se

  def initialize(merchants_file_path, se)
    @se = se
    @merchants = []
    contents = CSV.open merchants_file_path,
                 headers: true,
                 header_converters: :symbol
    contents.each do |row|
      id = (row[:id]).to_i
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      merchant = Merchant.new(id, name, created_at, updated_at, self)
      @merchants << merchant
    end
  end

  def all
    @merchants
  end

  def find_by_id(merchant_id)
    @merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    @merchants.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(fragment)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def fetch_merchant_id(merchant_id)
    se.fetch_merchant_id(merchant_id)
  end

  def fetch_invoices(merchant_id)
    se.fetch_invoices_for_merchant(merchant_id)
  end

  def fetch_customers_from_merchant_id(merchant_id)
    se.fetch_customers_from_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
