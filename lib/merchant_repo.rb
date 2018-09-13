require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class MerchantRepo < CsvAdaptor

  attr_reader :merchants,
              :data_file

  def initialize(data_file, merchants=[])
    @data_file = data_file
    @merchants = merchants
  end

  # def all_merchant_characteristics(data_file)
  #   load_merchants(data_file)
  # end

  def all
    @merchants
  end

  # def load_all_merchants
  #   load_merchants(data_file).each do |merchant_info|
  #     @merchants << Merchant.new(merchant_info)
  #   end
  # end

  # def find_by_id(id)
  #   @merchants.inject([]) do |array, merchant|
  #     if merchant.id == id
  #       merchant
  #     end
  #   end
  #   # nil
  # end

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
      merchant.name.downcase.include? name.downcase
    end
  end

  def find_highest_merchant_id
    m = @merchants.max_by do |merchant|
      merchant.id
    end
    m.id
  end

  def create(attributes)
    attributes[:id] = (find_highest_merchant_id + 1)
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    merchant = Merchant.new(attributes)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if merchant == nil
      do_nothing
    else
      merchant.name = attributes[:name]
      merchant.change_updated_at
    end
  end

  def delete(id)
    @merchants.delete_if do |merchant|
      merchant.id == id
    end
  end

  def merchant_array_from_file
    load_merchants(data_file).each do |merchant_info|
      @merchants << Merchant.new(merchant_info)
    end
  end

end
