require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :sales_engine

  def initialize(parent, filename)
    @merchants           = []
    @sales_engine        = parent
    @load                = load_file(filename)
  end

  def load_file(filename)
    merchant_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    merchant_csv.each do |row| @merchants << Merchant.new(row, self) end
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id.to_s}
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    parse_queue_partial_words("name", name)
  end

  def find_items(item_id)
    sales_engine.find_items(item_id)
  end

  def parse_queue_partial_words(column_name, criteria)
    results = []
    merchants.map do |row|
      next if row.name.include?(criteria) == false
      results << row
    end
    results
  end

end
