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
    @members.find_all do | member |
      member.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
      @members.find_all do | member |
      range.include?(member.unit_price)
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
    member = find_by_id(id)
    if member != nil
      if attributes[:name] != nil
        member.name = attributes[:name]
      end
      if attributes[:description] != nil
        member.description = attributes[:description]
      end
      if attributes[:unit_price] != nil
        member.unit_price = attributes[:unit_price]
      end
      member.updated_at = Time.new
    end
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Item.new(attributes))
  end
end
