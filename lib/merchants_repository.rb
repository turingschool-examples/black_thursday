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

end
