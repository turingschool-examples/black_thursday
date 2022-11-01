# frozen_string_literal: true
require './lib/item'

class ItemRepository
  def initialize(stats)
    @repository = []
    stats.each { |stat| create(stat) }
  end

  def create(stat)
    stat[:id] ||= (@repository.last.id.to_i + 1).to_s
    item = Item.new(stat)
    @repository.push(item)
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |item| item.id == id.to_s }
  end

  def find_by_name(name)
    @repository.find { |item| item.name.casecmp?(name) }
  end

  def find_by_description(description)
    @repository.select { |item| clean_description(item.description) == clean_description(description) }
  end

  def find_all_by_price(price)
    @repository.select { |item| item.unit_price_to_dollars == price }
  end

  def find_all_by_price_range(range)
    @repository.select { |item| range.include?(item.unit_price.to_f) }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |item| item.merchant_id == merchant_id.to_s }
  end

  def clean_description(desc)
    desc.downcase.gsub(/\s+/, '').gsub(/\n+/, '')
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end
end
