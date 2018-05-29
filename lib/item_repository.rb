require_relative 'item'
require_relative 'repository'
require 'bigdecimal'
require 'pry'

class ItemRepository < Repository
  def initialize
    super
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_with_description(fragment)
    desc = @members.map do | member |
      if member.description.downcase.include?(fragment.downcase)
        member
      end
    end
    desc = desc.compact
  end

  def find_all_by_price(price)
    by_price = @members.find_all do | member |
      if member.unit_price == price
        member
      end
    end
    by_price = by_price.compact
  end

  def find_all_by_price_in_range(range)
    sammo = @members.map do | member |
      if range.include?(member.unit_price)
        member
      end
    end
  end

  def find_all_by_merchant_id(id)
    by_merchant_id = @members.map do | member |
      if member.merchant_id == id
        member
      end
    end
    by_merchant_id = by_merchant_id.compact
  end


  def update(id, attributes)
    @members.each do | member |
      if member.id == id
        member.name = attributes[:name]
        member.description = attributes[:description]
        member.unit_price = attributes[:unit_price]
        member.updated_at = Time.now
      end
    end
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Item.new(attributes))
  end
end
