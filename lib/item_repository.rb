require_relative 'reposable'
require_relative './item.rb'
require 'bigdecimal'

class ItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def create(attributes)
    all << Item.new({ :name         => attributes[:name],
                      :id           => next_id,
                      :description  => attributes[:description],
                      :unit_price   => attributes[:unit_price],
                      :created_at   => Time.parse(attributes[:created_at].to_s),
                      :updated_at   => Time.parse(attributes[:updated_at].to_s),
                      :merchant_id  => attributes[:merchant_id]
                    })    
  end

  def update(id,attributes)
    if find_by_id(id) == nil 
      return
    else
    find_by_id(id).updated_at = Time.now
    attributes.each do |att,val|
      case att
      when :name
        find_by_id(id).name = val
      when :description
        find_by_id(id).description = val
      when :unit_price
        find_by_id(id).unit_price = val
      end
    end
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    all.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    all.select do |item|
      item.unit_price.to_f == price
    end
  end

  def find_all_by_price_in_range(range)
    all.select do |item|
      item.unit_price.to_f >= range.begin && item.unit_price.to_f <= range.end
    end
  end

  def find_all_by_merchant_id(id)
    all.select do |item|
      item.merchant_id.to_i == id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end