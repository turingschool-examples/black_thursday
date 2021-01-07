require_relative 'merchant'
require_relative 'sales_engine'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :path

  def initialize(path)
    @path = path
    @merchants = []
    read_merchant
  end

  def read_merchant
    CSV.foreach(@path, headers: :true , header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
    return @merchants
  end

  def all
    @merchants
  end

  def inspect
<<<<<<< HEAD
    "#<#{self.class} #{@merchants.size} rows>"
=======
      "#<#{self.class} #{@merchants.size} rows>"
>>>>>>> 4dc91ba51c3556dd194371de6606bb3775e1311f
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
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

  def highest_id
     @merchants.max do |merchant|
      merchant.id
    end
  end

  def create(attributes)
    attributes[:id] = highest_id.id + 1
    @merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    return nil if attributes.empty?
    update = find_by_id(id)
    update.name = attributes[:name]
  end

  def delete(id)
    deleted = find_by_id(id)
    @merchants.delete(deleted)
  end
end
