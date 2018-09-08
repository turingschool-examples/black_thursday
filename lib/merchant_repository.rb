require 'CSV'

class MerchantRepository
  attr_reader :merchants

  def initialize(file_path)
    @merchants = []
    load_merchants(file_path)
  end

  def all
    @merchants
  end

  def load_merchants(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def find_by_id(id_number)
    @merchants.find do |merchant|
      merchant.id == id_number
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found_all_names = @merchants.find_all do |merchant|
                        merchant.name.downcase.include?(name.downcase)
                      end
  end

  def create(attributes)
    attributes[:id] = @merchants[-1].id + 1
    @merchants << Merchant.new(attributes)
  end

end
