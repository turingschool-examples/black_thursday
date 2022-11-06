# frozen_string_literal: true
require_relative 'repository'

class ItemRepository < Repository

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?

    attributes.each do |key, value|
      next if [:id, :merchant_id, :created_at].include?(key)

      item.instance_variable_set("@#{key}", value)
    end
    item.updated_at = Time.now
  end

  # def delete(id)
  #   @all.delete(find_by_id(id))
  # end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end