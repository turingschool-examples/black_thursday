require_relative 'repository'
require_relative 'item'
require 'bigdecimal'

class ItemRepository < Repository
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

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Item.new(attributes))
  end
end
