require 'csv'
require_relative '../lib/invoice_item.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class InvoiceItemRepository
  attr_reader :list
  include RepoMethodHelper

  def initialize(list)
    @list = list
  end

  def find_all_by_item_id(item_id)
    @list.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = InvoiceItem.new(attributes)
    @list << created
    created
  end

  def update(id, attributes)
    find_by_id(id).quantity = attributes[:quantity] unless attributes[:quantity].nil?
    find_by_id(id).unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end
end
