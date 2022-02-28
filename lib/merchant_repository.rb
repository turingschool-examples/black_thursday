# merchant_repository
require 'CSV'

class MerchantRepository
  attr_reader :merchants

  def initialize(file)
    @merchants = []
    open_merchants(file)
  end

  def open_merchants(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(fragment)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(fragment) }
  end

  def create(attributes)
    @merchants.sort_by { |merchant| merchant.id }
    last_id = @merchants.last.id
    attributes[:id] = (last_id += 1)
    @merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    attributes.map do |key, v|
      # require "pry"; binding.pry
      merchant.name = v if key == :name
    end
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
