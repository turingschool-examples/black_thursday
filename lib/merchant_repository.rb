require 'csv'
require_relative '../lib/merchant'

class MerchantRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_merchants(path)
  end

  def create_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.new(row)
      @all << merchant
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attribute)
    new_id = @all.max_by do |merchant|
      merchant.id
    end
    merchant = Merchant.new({:id => new_id.id + 1, :name => attribute[:name]})
    @all << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if !merchant.nil?
      merchant.update(attributes)
    end
  end

  # def update(id, new_name)
    # name_edit = find_by_id(id)
    # if name_edit != nil
    #   name_edit.name = new_name[:name]
    # end
  # end

  def delete(id)
    delete_merchant = find_by_id(id)
    @all.delete(delete_merchant)
  end
end
