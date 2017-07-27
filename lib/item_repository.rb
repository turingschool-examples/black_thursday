require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :sales_engine,
              :id_repo,
              :price_repo,
              :file_path,
              :sales_engine

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
      load_to(@id_repo, item, row[:id].to_i)
      load_to(@name_repo, item, row[:name])
      load_to(@description_repo, item, row[:description])
      load_to(@price_repo, item, row[:unit_price].to_f)
      load_to(@merchant_id_repo, item, row[:merchant_id])
    end
  end

  def all
    @id_repo.values
  end

  def find_by_id(id)
    id_repo[id]
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
      if key_value.downcase.include?(description.downcase)
        results << @description_repo[key_value]
      end
    end
    results.flatten
  end

  def find_all_by_price(price)
    items = id_repo.values.select do |item_instance|
      item_instance.unit_price == price
    end
    items
  end

  def find_all_by_price_in_range(range)
    items = id_repo.values.select do |item_instance|
      range.include?(item_instance.unit_price)
    end
    items
  end

  def find_all_by_merchant_id(merchant_id)
    if @merchant_id_repo.include?(merchant_id.to_s)
      [@merchant_id_repo[merchant_id.to_s]].flatten
    else
      []
    end
  end

  def repo_to_se(merchant_id)
    @sales_engine.merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
