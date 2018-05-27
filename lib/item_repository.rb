require './lib/item'

class ItemRepository < Repository
  def initialize
    super
  end

  def find_all_with_description(fragment)
    @members.map do | member |
      if member.description.include?(fragment)
        member
      end
    end
  end

  def find_all_by_price(price)
    @members.map do | member |
      if member.price == price
        member
      end
    end
  end

  def find_all_by_price_in_range(range)
    @members.map do | member |
      if range.include?(member.price)
        member
      end
    end
  end

  def find_all_by_merchant_id(id)
    @members.map do | member |
      if member.merchant_id == id
        member
      end
    end
  end

  def create(attributes)
    super
    @members.push(Item.new(attributes))
  end
end
