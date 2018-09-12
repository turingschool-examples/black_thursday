require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class MerchantRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    is_included = @all.any? do |merchant|
      attributes[:id] == merchant.id
    end
    has_id = attributes[:id] != nil
    is_included = false if @all == []
    if has_id && !is_included
      @all << Merchant.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << Merchant.new(attributes)
    else
      highest_id = @all.max_by do |merchant|
        merchant.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << Merchant.new(attributes)
    end
  end

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i
      attributes_array << object.to_h
    end
    attributes_array.each do |hash|
      create(hash)
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
