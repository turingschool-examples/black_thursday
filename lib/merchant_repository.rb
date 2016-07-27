class MerchantRepository
  attr_reader :merchants

  def initialize(merchant_contents)
    @merchants = make_merchants(merchant_contents)
  end

  def make_merchants(merchant_contents)
    merchant_contents.map { |row| make_merchant(row) }
  end

  def make_merchant(row)
    data = make_prepared_data(row)
    Merchant.new(data)
  end

  def make_prepared_data(row)
    { id:   row[:id].to_i,
      name: row[:name]
    }
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merc| merc.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merc| merc.name.upcase == name.upcase }
  end

  def find_all_by_name(name)
    @merchants.find_all { |merc| merc.name.upcase.include? name.upcase }
  end
end
