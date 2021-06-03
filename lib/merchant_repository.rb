require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :id, :name, :all, :merchants, :file_path

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
  end

  def create_repo
    @merchants = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.new(row, self)
      @merchants << merchant
    end
    self
  end

  def all
    merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    merchant_id = merchants.max { |merchant| merchant.id }
    attributes[:id] = merchant_id.id + 1
    attributes[:created_at] = Time.now.strftime("%Y-%m-%d")
    attributes[:updated_at] = Time.now.strftime("%Y-%m-%d")
    @merchants << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    #for any given ID value, we are looking through the merchants
    # if that ID exists, execute following code
    # if it doesnt, return nil
    merchant_by_id = find_by_id(id)
    if merchant_by_id != nil
      merchant_by_id.change_name(attributes[:name])
    end
  end

  def delete(id)
    #for any given ID value, we are looking through the merchants
    # if that ID exists, delete it
    # if it doesnt, return nil
    chopping_block = merchants.index { |merchant| merchant.id == id }
    if chopping_block != nil
      merchants.delete_at(chopping_block)
    end
  end

end
