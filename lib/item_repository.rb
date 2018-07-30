# frozen_string_literal: true

require_relative './item'
require_relative './repository_helper'
require 'time'
require 'bigdecimal'

# Item repository class
class ItemRepository
  include RepositoryHelper

  def update(id, params)
    return nil unless @repository.key?(id)
    sig_fig = params[:unit_price].to_s.size - 1

    item = find_by_id(id)
    item.name = params[:name] unless params[:name].nil?
    item.description = params[:description] unless params[:description].nil?
    item.unit_price = BigDecimal(params[:unit_price], sig_fig) unless params[:unit_price].nil?
    item.updated_at = Time.now
  end

  def find_all_with_description(input)
    all.find_all do |item|
      item.description.downcase.include?(input.downcase)
    end
  end

  def find_all_by_price(price)
    float_price = price.to_f
    all.find_all do |item|
      item.unit_price_to_dollars == float_price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.member?(item.unit_price)
    end
  end

  private

  def sub_class
    Item
  end
end
