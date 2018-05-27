require './lib/item'

class ItemRepository < Repository
  def initialize
    super
  end

  def find_all_with_description(fragment)
    @members.map do | member |
      if member.description.downcase.include?(fragment.downcase)
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

  def update(id, attributes)
    super
    @members.each do | member |
      if member.id == id
        member.description = attributes[:description]
        member.unit_price = attributes[:unit_price]
        member.updated_at = Time.now
      end
    end
  end
end
