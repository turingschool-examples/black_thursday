class MerchantsRepository
  attr_reader :all

  def initialize(merchant_array)
    @all = merchant_array
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name)
    @all.find_all {|merchant| merchant.name.upcase.include? name.upcase}
  end

  def create(attributes)
    # new_id = (@all.max {|merchant| merchant.length}) + 1
    # new_merch_hash = {}
    # new_merch_hash[:id] = new_id
    # new_merch_hash[:name] = attributes
    # @all.push(Merchant.new(new_merch_hash))
  end

end
