require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    make_merchants(path)
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
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

  def create(attributes)
    max_id = @merchants.max_by do |merchant|
      merchant.id
    end
    attributes[:id] = max_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @merchants << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    if attributes.keys[0] != :name
      return
    else
      updatee = find_by_id(id)
      updatee.name.replace(attributes[:name])
    end
  end

  def delete(id)
    deletee = find_by_id(id)
    @merchants.delete(deletee)
  end

  def all_items
    @engine.all_items
  end

  def merchant_total_items
    merchants.map do |merchant|
      all_items.count do |item|
        merchant.id == item.merchant_id
      end
    end
  end

  def merchant_items
    merchant_id_hash = merchants.each_with_object({}) do |merchant, hash|
      hash[merchant] = []
    end
    merchant_id_hash.group_by do |key, value|
      all_items.each do |item|
        if item.merchant_id == key.id
          merchant_id_hash[key] << item
        end
      end
    end
    merchant_id_hash
  end

  def average_items_per_merchant
    avg = merchant_total_items.sum.to_f / @merchants.count
    avg.round(2)
  end

  def average_items_per_merchant_standard_deviation
    numerator = merchant_total_items.inject(0) do |summation, item|
      summation + (item - average_items_per_merchant) ** 2
    end
    sample_variance = numerator / (merchant_total_items.length - 1).to_f
    (Math.sqrt(sample_variance)).round(2)
  end

  def merchants_with_high_item_count
    merchants_with_high_item_count = []
    merchant_items.each do |key, value|
      if value.count > average_items_per_merchant_standard_deviation + average_items_per_merchant
        merchants_with_high_item_count << key
      end
    end
    merchants_with_high_item_count
  end
end
