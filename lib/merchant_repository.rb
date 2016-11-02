require_relative 'merchant'

class MerchantRepository

  attr_reader :all

  def initialize(merchants)
    @all = merchants
  end

  def find_by_id(id)
    all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name_fragment)
    all.find_all do |merchant|
      merchant.name.upcase.include?(name_fragment.upcase)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end


