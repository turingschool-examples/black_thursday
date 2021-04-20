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

  def find_all_by_name(name)
    RepoBrain.find_all_by_partial_string(name, 'name', @merchants)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @merchants)
  end

  def find_by_name(name)
    RepoBrain.find_by_full_string(name, 'name', @merchants)
  end

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@merchants)
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @merchants << Merchant.new(attributes, self)
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def merchants_created_in_month(month)
    @merchants.each_with_object([]) do |merchant, array|
      if merchant.created_at.strftime("%B") == month
        array << merchant
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    items_hash = @engine.items_created_in_month(month)
    merchants_month_hash = merchants_created_in_month(month)
    merchants_month_hash.find_all do |merchant|
      !items_hash[merchant.id].nil? && items_hash[merchant.id] == 1
    end
  end

  def top_revenue_earners(num_earners)
    array = @engine.total_revenue_by_merchant.select{|x| x % 1 == 0}.first(num_earners)
    array.map do |merchant_id|
      find_by_id(merchant_id)
    end
  end

  def update(id, attributes)
    if !find_by_id(id).nil?
      customer_to_update = find_by_id(id)
      customer_to_update.update(attributes)
    end
  end
end
