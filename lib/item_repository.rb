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
    sanitized_attributes = {
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price],
      updated_at: Time.now
    }
    super(id, sanitized_attributes)
  end
end
