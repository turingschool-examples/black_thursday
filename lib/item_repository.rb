
require 'pry'
require_relative 'module'
class ItemRepository
include IDManager
attr_accessor :all
  def initialize(items)
    @all = items
  end
#inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_description(search)
    @all.find_all{|index| index.description.upcase.include?(search.upcase)}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all{|index| index.merchant_id == (merchant_id)}
  end

  def find_all_by_price(price)
   # @all.find_all{|index| index.unit_price.to_f == price}
   @all.find_all{|index| index.unit_price == (BigDecimal(price,4))}
  end

  def find_all_by_price_in_range(range)
   @all.find_all{|index| range.include?(index.unit_price)}
  end

  # def update(id, attributes)
  #   @all.each do |index|
  #     binding.pry
  #     if index.id == id
  #       index.updated_at = Time.now
  #       index.description = attributes[:description]
  #       index.name = attributes[:name]
  #       index.unit_price = attributes[:unit_price]
  #     end
  #   end
  # end


end
