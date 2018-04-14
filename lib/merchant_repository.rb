# Frozen_string_literal: true

require 'CSV'
require_relative 'merchant'
# Merchant Repository
class MerchantRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents[row[:id]] = Merchant.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    all.find_all { |merchant| merchant.downcase == name.downcase }
  end

  def create(attributes)
    max_id = @contents.max_by do |key|
      key
    end
    max = max_id[0].to_i + 1
    attributes[:id] = max
    @contents[:max] = Merchant.new(attributes, self)
  end

  def update(id, attributes)
    @contents[id] = attributes
  end

  def delete(id)
    @contents.delete(id)
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end
end
