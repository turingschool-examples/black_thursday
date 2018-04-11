# frozen_string_literal: true

require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

# This is a SalesEngine Class
class SalesEngine
  def self.from_csv(path)
    new(path).tap(&:populate_repositories)
  end

  def initialize(path = nil)
    @path = path
  end

  def populate_repositories
    items.populate
    merchants.populate
  end

  def items
    @items ||= ItemRepository.new(data_for(:items))
  end

  def merchants
    @merchants ||= MerchantRepository.new(data_for(:merchants))
  end

  def path
    @path || filepath
  end

  def filepath
    {
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
    }
  end

  def data_for(type)
    CSV.read(path.fetch(type), headers: true, header_converters: :symbol)
  end
end
