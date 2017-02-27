require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_data, :all, :parent

  def initialize(merchant_data, parent = nil )
    @merchant_data = merchant_data
    @all = merchant_data.map { |row| Merchant.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    all.find {|object| object.id == id }
  end

  def find_by_name(name)
    all.find { |object| object.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    all.find_all do |object|
      object.name.downcase.include?(name.downcase)
    end
  end

  def inspect
    binding.pry
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
