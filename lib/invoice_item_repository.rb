require_relative 'repo_methods'
require_relative 'invoice_item'
require 'bigdecimal'

class InvoiceItemRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, InvoiceItem.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = InvoiceItem.new(attributes)
  end

  def update(current_id, new_attributes)
    if @collection[current_id] == nil
    else
      @collection[current_id].update_unit_price(new_attributes) if new_attributes[:unit_price]
      @collection[current_id].update_quantity(new_attributes) if new_attributes[:quantity]
      @collection[current_id].update_updated_at(Time.now)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end


end
