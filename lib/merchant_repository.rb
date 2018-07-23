class MerchantRepository
  def initialize(merchant_data)
    @merchant_rows ||= build_merchant(merchant_data)
    @merchants = @merchant_rows #shops = an array of merchants, might change this name
  end

  def build_merchant(merchant_data)
    merchant_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant| #rubocop wants the line below
      merchant.name.casecmp(name).zero? # if case-insensitive returns 0, = the same name
    end
  end

  def find_all_by_name(fragment)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def create_id
    find_highest_id.id + 1
  end

  def find_highest_id
    @merchants.max_by do |merchant|
      merchant.id
    end
  end
end
