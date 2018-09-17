require_relative './item'
require_relative './repo_methods'
require 'time'
require 'CSV'
require 'pry'

class ItemRepository
  include RepoMethods
  attr_reader :objects_array
  def initialize(file_path)
    @objects_array = item_csv_converter(file_path)
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

  def find_by_name(name)
    findings = @objects_array.find_all do |item|
      item.name.downcase == name.downcase
    end
    findings[0]
  end

  def find_all_with_description(description)
    findings = @objects_array.find_all do |item|
      item.description.downcase =~ /#{description.downcase}/
    end
  end

  def find_all_by_price(price)
    @objects_array.find_all do |item|
      price == item.unit_price
    end
  end

  def find_all_by_price_in_range(range)
    integers = range.to_s.split('..')
    @objects_array.find_all do |item|
      item.unit_price >= integers[0].to_i and item.unit_price <= integers[1].to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    findings = @objects_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    max_id = generate_id
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :name => attributes[:name],
                  :description => attributes[:description],
                  :unit_price => attributes[:unit_price],
                  :merchant_id => attributes[:merchant_id],
                  :created_at => time,
                  :updated_at => time }
    @objects_array << Item.new(attributes)
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
end
