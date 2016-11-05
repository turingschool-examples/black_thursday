require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader   :all,
                :parent

  def initialize(merchants_data, parent = nil)
    @parent = parent
    @all = []
    populate(merchants_data)
  end

  def populate(merchants_data)
    merchants_data.each do |merchant|
      @all << Merchant.new(merchant, self)
    end
  end

  def average_items_per_merchant
    @item_counts = @all.map { |merchant| merchant.items.size }
    average(@item_counts)
  end

  def average_item_price_for_merchant(id)
    all_prices = find_all_items_by_merchant(id).map do |item|
      item.unit_price
    end
    average(all_prices).to_f
  end

  def average_average_price_per_merchant
    averages = @all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(averages).to_f
  end

  def average(collection)
    collection.reduce(&:+) / collection.size
  end

  def merchants_with_most_items
    names = @all.map { |merchant| merchant.name }
    @item_counts.sort!.reverse!
    @item_counts.zip(names)[0..2]
  end

  def find_by_id(id_number)
    @all.find do |merchant|
      if merchant.id == id_number.to_i
        merchant.name
      else
        nil
      end
    end
  end

  def find_by_name(merch_name)
    @all.find do |merchant|
      if merchant.name.downcase == merch_name.downcase
        merchant.id
      else
        nil
      end
    end
  end

  def find_all_by_name(fragment)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_items_by_merchant(merchant_id)
    parent.find_all_items_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
