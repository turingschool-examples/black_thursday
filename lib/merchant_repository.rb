require 'merchant'
class MerchantRepository
  attr_reader :all, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open("#{@file_path}", headers: true, :header_converters => :symbol)
    info.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def new_id
    max_id = @all.max_by(&:id) 
    max_id.id += 1
  end

  def create(attributes)
    merchant_id = @all.max { |merchant| merchant.id}
    attributes[:id] = merchant_id.id + 1
    @all << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if !merchant.nil?
      merchant.update_merchant(attributes)
    else
      nil
    end
  end

  def delete(id)
    deleted_merchant = find_by_id(id)
    @all.delete(deleted_merchant)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
