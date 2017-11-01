require './lib/item'

class ItemRepository
  attr_reader :items,
              :count,
              :all,
              :sales_engine,
              :find_by_id,
              :merchant,
              :find_all_by_merchant_id,
              :find_by_name,
              :find_by_price,
              :find_all_by_description,
              :find_all_by_price_in_range

  def initialize(parent)
    @items = []
    @sales_engine = parent
  end

  def create_item(data)
      my_reference = self
      item_search =  CSV.foreach  data[:items], headers: true, header_converters: :symbol do |row|
        @items << Item.new(row, my_reference)
      end
  end

  def all
    @items
  end

  def find_by_id(id)

      item = @items.find{|item| item.id == id}

    end

  def find_by_name(name)
    item =  @items.find{|item| name if item.name == name}

  end

  def find_all_by_description(description)
   items = @items.find_all{|item| item.description == description}

  end

  def find_by_price(price)
    items = @items.find {|item| item.unit_price == price}
    # items.name
  end

  def find_all_by_price_in_range(low_price, high_price)
    items = @items.find_all do |item|
       item.unit_price.to_i < high_price.to_i && item.unit_price.to_i > low_price.to_i
    end
    items.map{|item|item.name}
  end

  # def find_all_by_merchant_id(merchant_id)
  #   items=  @items.find_all{|item| item.merchant_id == merchant_id}
  #   items.first# items.first.merchant_i
  # end

  def merchant(id)
    @sales_engine.merchant(id)
  end

end
