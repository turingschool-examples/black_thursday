# Frozen_string_literal: true

require 'CSV'
require_relative 'merchant'
require_relative 'repository'
# Merchant Repository
class MerchantRepository
  attr_reader :merchants,
              :parent
  include Repository
  def initialize(path, parent)
    @merchants = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @merchants[row[:id].to_i] = Merchant.new(row, self)
    end
  end

  def all
    @merchants.values
  end

  def find_by_id(id)
    @merchants[id]
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    max_id = @merchants.keys.max + 1
    attributes[:id] = max_id
    @merchants[:max] = Merchant.new(attributes, self)

  end

  def update(id, attributes)
    @merchants[id] = attributes
  end

  def delete(id)
    @merchants.delete(id)
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end
end
