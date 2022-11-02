# frozen_string_literal: true

require './lib/item'
require './lib/general_repo'

# This is the item_repository class
class ItemRepository < GeneralRepo
  def initialize(data)
    super(data, 'Item')
  end

  def find_by_name(name)
    @repository.find { |item| item.name.casecmp?(name) }
  end

  def find_by_description(description)
    @repository.select { |item| clean_string(item.description).casecmp?(clean_string(description)) }
  end

  def find_all_by_price(price)
    @repository.select { |item| item.unit_price_to_dollars == price }
  end

  def find_all_by_price_range(range)
    @repository.select { |item| range.include?(item.unit_price_to_dollars) }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |item| item.merchant_id == merchant_id.to_s }
  end

  def clean_string(desc)
    desc.gsub(/\s+/, '').gsub(/\n+/, '')
  end
end
