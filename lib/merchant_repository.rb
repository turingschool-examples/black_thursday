require "csv"
require_relative "merchant"
require_relative "sales_engine"


class MerchantRepository

  attr_reader :all, :sales_engine

  def initialize(sales_engine, merchant_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(
      merchant_csv, headers: true, header_converters: :symbol) do |row|
        @all << Merchant.new(self, row)
      end
    @id = :id
    @name = :name
  end

  def find_by_id(id)
    all.each do |merchant|
      return merchant if merchant.id == id
    end
    nil
  end

  def find_by_name(name)
    all.each do |merchant|
      return merchant if merchant.name.downcase == name.downcase
    end
    nil
  end

  def find_all_by_name(name)
    all.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def merchants_registered_in_month(month)
    all.select do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
  end

  def inspect
    "#<#{self.class} #{:merchants.size} rows>"
  end

end
