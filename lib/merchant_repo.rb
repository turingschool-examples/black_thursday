require 'merchant'
include Findable 

class MerchantRepo
  attr_reader :merchants,
              :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def all
    @merchants
  end

  # def find_all_by_name(name_fragment)
  #   @merchants.find_all do |merchant|
  #     merchant.name.downcase.include?(name_fragment.downcase)
  #   end
  # end

  def create(attributes)
    merchant = Merchant.new(attributes, self)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.update_id(max.id)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return if !merchant
    merchant.update_name(attributes)
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def item_count
    count = @engine.items.all.length
    count.to_f
  end

  def merchant_count
    count = all.length
    count.to_f
  end 

  def average_items_per_merchant
    (item_count / merchant_count).round(2)
  end

  def item_count_per_merchant
    @engine.items.item_count_per_merchant
  end

  def average_items_per_merchant_standard_deviation 
    average_items = average_items_per_merchant
    sum = item_count_per_merchant.sum do |merchant, count|
      (average_items - count)**2
    end
    sum = (sum / (merchant_count - 1))
    (sum ** 0.5).round(2)
  end

  def merchants_with_high_item_count 
    one_deviation = average_items_per_merchant_standard_deviation + average_items_per_merchant
    high_merchants = []
    item_count_per_merchant.find_all do |id, count|
      high_merchants << find_by_id(id) if count > one_deviation
    end
    high_merchants
  end

  def average_average_price_per_merchant 
    all_items = item_count_per_merchant.length
    all_averages = all.sum do |merchant|
     @engine.average_item_price_for_merchant(merchant.id)
    end
    (all_averages / all_items).round(2)
  end
end
