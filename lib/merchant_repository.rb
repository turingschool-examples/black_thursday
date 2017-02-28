require_relative 'merchant'

class MerchantRepository
  attr_accessor :merchants
  attr_reader :merchant_repository, :merchant_csv, :se_parent

  def initialize(merchant_csv = nil, se_parent)
    @merchant_csv = CSV.open merchant_csv, headers: true, header_converters: :symbol
    @se_parent = se_parent
    make_merchant_repository
  end

  def make_merchant_repository
    @merchant_repository = {}
    @merchant_csv.read.each do |merchant|
      @merchant_repository[merchant[:id]] = Merchant.new(merchant, self)
    end
    return self
  end

  def inspect
    "#<#{self.class} #{merchant_repository.size} rows>"
  end

  def all
    merchant_repository.map do |key, value|
      value
    end
  end

  def find_by_id(id)
    if merchant_repository[id.to_s]
      merchant_repository[id.to_s]
    else
      nil
    end
  end

  def find_by_name(name_search)
    all.find do |merchant|
      merchant.name.downcase == name_search.downcase
    end
  end

  def find_all_by_name(partial)
    all.find_all do |merchant|
      merchant.name.downcase.include?(partial.downcase)
    end
  end

  # def generate_revenue_array
  #   revenue_array = all.map do |merchant|
  #     {merchant => merchant.revenue}
  #   end
  #   @revenue_array = revenue_array.sort_by { |hash| -hash.values[0]}
  # end

end
