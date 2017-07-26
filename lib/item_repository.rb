require 'csv'
require './lib/item'
require 'pry'

class ItemRepository
  attr_reader :sales_engine
  def initialize(file_path, sales_engine)
    @file_path =        file_path
    @sales_engine =     sales_engine
    @id_repo =          {}
    @name_repo =        {}
    @description_repo = {}
    @price_repo =       {}
    @merchant_id_repo = {}
    load_repo
  end

  def load_to(repo, item, key_value)
    if !(repo.include?(key_value))
      repo.store(key_value, item)
    elsif repo[key_value].is_a?(Array)
      repo[key_value] << item
    else
      new_value = [repo[key_value], item]
      repo.store(key_value, new_value)
    end
  end

  def load_repo
    itemcsv = CSV.open @file_path, headers: true, header_converters: :symbol
    itemcsv.each do |row|
      item_hash = Hash[row]
      item = Item.new(item_hash, self)
      load_to(@id_repo, item, row[:id])
      load_to(@name_repo, item, row[:name])
      load_to(@description_repo, item, row[:description])
      load_to(@price_repo, item, row[:unit_price])
      load_to(@merchant_id_repo, item, row[:merchant_id])
    end
  end

  def all
    @id_repo.values
  end

  def find_by_id(id)
    if @id_repo.include?(id.to_s)
      @id_repo[id.to_s]
    else
      nil
    end
  end

  def find_by_name(name)
    if @name_repo.include?(name)
      @name_repo[name]
    else
      nil
    end
  end

  def find_all_with_description(description)
    results = []
    @description_repo.keys.each do |key_value|
      if key_value.include?(description)
        results << @description_repo[key_value]
      end
    end
    results.flatten
  end

  def find_all_by_price(price)
    if @price_repo.include?(price.to_s)
      [@price_repo[price.to_s]].flatten
    else
      []
    end
  end

  def find_all_by_price_in_range(price_minimum, price_maximum)
    results = []
    @price_repo.keys.each do |key_value|
      if key_value.to_i > price_minimum && key_value.to_i < price_maximum
        results << @price_repo[key_value]
      end
    end
    results.flatten
  end

  def find_all_by_merchant_id(merchant_id)
    if @merchant_id_repo.include?(merchant_id.to_s)
      [@merchant_id_repo[merchant_id.to_s]].flatten
    else
      []
    end
  end
end
