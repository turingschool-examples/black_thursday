require_relative '../lib/file_extractor'
require_relative '../lib/merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @merchants = {}
    merchants_data = FileExtractor.extract_data(load_path)
    populate(merchants_data)
  end

  def format_merchant_info(merchant)
    { :id   => merchant[:id],
      :name => merchant[:name] }
  end

  def make_merchant(merchant_data)
    merchant_formatted = format_merchant_info(merchant_data)
    @merchants[merchant_data[:id].to_i] = Merchant.new(merchant_formatted, self)
  end

  def populate(merchants_data)
    merchants_data.each do |merchant_data|
      make_merchant(merchant_data)
    end
  end

  def all
    merchants.values
  end

  def find_by_id(merchant_id)
    merchants[merchant_id]
  end

  def find_by_name(merchant_name)
    merchants.values.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    merchants.values.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_items_by_merchant_id(merchant_id)
    @sales_engine_parent.find_items_by_merchant_id(merchant_id)
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end
end
