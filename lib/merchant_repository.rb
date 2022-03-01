require_relative "module"

class MerchantRepository
  include IDManager

attr_reader :all
  def initialize(merchants)
    @all = merchants
  end
  def find_all_by_name(search)
    @all.find_all{|index| index.name.upcase.include?(search.upcase)}
  end
  def create(attributes)
    new_element = attributes
    new_element[:id] = (@all.max{|index| index.id}).id + 1
    @all << Merchant.new(new_element)
  end
  def update(id, attributes)
    seleted_instance = find_by_id(id)
    attributes.each do |key, value|
      seleted_instance.name = value
    end 
  end
#inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
