# frozen_string_literal: true

require_relative './repository'
require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'item'
# stores items and gives methods for item search
class ItemRepository
  include Repository
  attr_reader :repository

  def initialize(items)
    item_array = []
    @repository = {}
    items.each {|item| item_array << Item.new(to_item(item))}
    item_array.each do |item|
      unless item.nil?
        @repository[item.id] = item
      end
    end
  end

  def to_item(item)
    item_hash = {}
    item.each do |line|
      item_hash[line[0].to_sym] = line[1]
    end
    item_hash
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at].nil?
      attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    item = Item.new(attributes)
    @repository[item.id] = item
  end

  def sterilize_attributes(attributes, item)
    temp_attr = attributes.dup
    temp_attr[:id] = item.attributes[:id]
    temp_attr[:merchant_id] = item.attributes[:merchant_id]
    temp_attr[:created_at] = item.attributes[:created_at]
    temp_attr
  end
end
