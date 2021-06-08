require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/modules/findable'
require_relative '../lib/modules/crudable'

class MerchantRepository
  include Findable
  include Crudable
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

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    create_new(attributes, Merchant)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return merchant.update(attributes) unless merchant.nil?
  end

  def delete(id)
    delete_new(id)
  end
end
