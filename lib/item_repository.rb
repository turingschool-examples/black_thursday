require_relative 'item'

class ItemRepository
  attr_reader :item_repo,
              :parent

  def initialize(loaded_file, parent)
    @item_repo = loaded_file.map { |item| Item.new(item, self)}
    @parent = parent
  end

  def all
    @item_repo
  end

  def find_by_id(id_num)
    item_repo.find {|item| item.id == id_num}
  end

  def find_by_name(name)
    item_repo.find {|item| item.name == name}
  end

  def find_all_with_description(description)
    item_repo.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    item_repo.find_all {|item| item.unit_price.to_f == price.to_f}
  end

  def find_all_by_price_in_range(range)
    item_repo.find_all {|item| range.include?(item.unit_price.to_f)}
  end

  def find_all_by_merchant_id(merchant_id)
    item_repo.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(attributes)
    highest = all.max_by {|item| item.id.to_i }
    item = {name: attributes[:name],
            description: attributes[:description],
            unit_price: convert_price(attributes),
            id: (highest.id + 1),
            created_at: attributes[:created_at],
            updated_at: attributes[:updated_at],
            merchant_id: attributes[:merchant_id]}
    @item_repo.push(Item.new(item, self))
  end

  def convert_price(attributes)
    if attributes[:unit_price].class == BigDecimal
      (attributes[:unit_price] * 100).to_i
    else
      attributes[:unit_price]
    end
  end

  def inspect
   "#{self.class} #{@item_repo.size} rows"
  end
end
