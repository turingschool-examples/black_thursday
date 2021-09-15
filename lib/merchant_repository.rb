require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :path,
              :all

  def initialize(path)
    @path = path
    @all  = read_file
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def read_file
    rows = CSV.read(@path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name) # include
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)

    max_id = @all.max_by do |merchant| # could split this into a helper method
      merchant.id
    end

    attributes[:id] = max_id.id + 1

    new_merchant = Merchant.new(attributes)
    @all << new_merchant
    new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
    merchant
  end

  def delete(id)
    merchant = find_by_id(id)

    @all.delete(merchant)
  end
end
