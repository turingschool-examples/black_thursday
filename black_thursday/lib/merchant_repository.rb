require "CSV"
class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(merchants, parent = "")
    @merchants = load_csv(merchants).map { |row| Merchant.new(row, self) }
    @parent    = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.to_s.downcase == name.to_s.downcase
    end
  end

end
