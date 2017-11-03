require_relative "merchant"
require "csv"

class MerchantRepository
  attr_reader :merchants

  def initialize(merchant_file)
    @merchants = []
    merchants_from_csv(merchant_file)
  end

  def merchants_from_csv(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
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

  def inspect
    "#{self.class} #{merchants.size} rows"
  end

end
