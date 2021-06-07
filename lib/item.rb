require 'bigdecimal'
require 'time'
require_relative 'helper_methods'

class Item
  include HelperMethods
  attr_reader :repo
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(item_hash, repo)
    @id = item_hash[:id].to_i
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal(item_hash[:unit_price]) / 100
    @created_at = Time.parse(item_hash[:created_at].to_s)
    @updated_at = Time.parse(item_hash[:updated_at].to_s)
    @merchant_id = item_hash[:merchant_id]
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:name] = @name
    self_hash[:description] = @description
    self_hash[:unit_price] = @unit_price
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash[:merchant_id] = @merchant_id
    self_hash
  end

end
