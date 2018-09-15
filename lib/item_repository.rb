require_relative './item'
require 'time'
require 'pry'

class ItemRepository
  attr_reader :items_array
  def initialize(file_path)
    @items_array = item_csv_converter(file_path)
  end

  def item_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:merchant_id] = obj[:merchant_id].to_i
      obj[:unit_price] = BigDecimal.new(obj[:unit_price])/100
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      Item.new(obj.to_h)
    end
  end

  def inspect
    "#<#{self.class} #{@items_array.size} rows>"
  end

  def all
    @items_array
  end

  def find_by_id(id)
    findings = @items_array.find_all do |item|
      item.id == id
    end
    findings[0]
  end

  def find_by_name(name)
    findings = @items_array.find_all do |item|
      item.name.downcase == name.downcase
    end
    findings[0]
  end

  def find_all_with_description(description)
    findings = @items_array.find_all do |item|
      item.description.downcase =~ /#{description.downcase}/
    end
  end

  def find_all_by_price(price)
    @items_array.find_all do |item|
      price == item.unit_price
    end
  end

  def find_all_by_price_in_range(range)
    integers = range.to_s.split('..')
    @items_array.find_all do |item|
      item.unit_price >= integers[0].to_i and item.unit_price <= integers[1].to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    findings = @items_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    last_item = @items_array.last
    if last_item == nil
      max_id = 1
    else
      max_id = last_item.id + 1
    end
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :name => attributes[:name],
                  :description => attributes[:description],
                  :unit_price => attributes[:unit_price],
                  :merchant_id => attributes[:merchant_id],
                  :created_at => time,
                  :updated_at => time }
    @items_array << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    attributes.each do |attribute, value|
      if attribute == :name
        item.name = value
        item.updated_at = Time.new.getutc
      elsif attribute == :description
        item.description = value
        item.updated_at = Time.new.getutc
      elsif attribute == :unit_price
        item.unit_price = value
        item.updated_at = Time.new.getutc
      else
        'You can not modify this attribute'
      end
    end
  end

  def delete(id)
    item = find_by_id(id)
    if item != nil
      @items_array.delete(item)
    else
      puts "Item not found"
    end
  end
end
