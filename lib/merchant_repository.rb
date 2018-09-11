require 'time'
require_relative './merchant'
require_relative'./sales_engine'

class MerchantRepository
  attr_reader :merchants_array
  def initialize(file_path)
    @merchants_array = merchant_csv_converter(file_path)
  end

  def merchant_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      Merchant.new(obj.to_h)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants_array.size} rows>"
  end

  def all
    @merchants_array
  end

  def find_by_name(name)
    findings = @merchants_array.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
    findings[0]
  end

  def find_by_id(id)
    findings = @merchants_array.find_all do |merchant|
      merchant.id == id
    end
    findings[0]
  end

  def find_all_by_name(name)
    @merchants_array.find_all do |merchant|
      merchant.name.downcase =~ /#{name.downcase}/
    end
  end

  def create(name)
    last_merchant = @merchants_array.last
    if last_merchant == nil
      max_id = 1
    else
      max_id = last_merchant.id + 1
    end
    attributes = {:id => max_id, :name => name[:name]}
    @merchants_array << Merchant.new(attributes)
  end

  def update(id, attributes)
    name = attributes[:name]
    merchant = find_by_id(id)
    if merchant != nil and name != nil
      merchant.updated_at = Time.new.getutc
      merchant.name = name
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    if merchant != nil
      index = @merchants_array.index(merchant)
      @merchants_array.delete_at(index)
    else
      puts "Merchant not found"
    end
  end
end
