require_relative 'merchant'

class MerchantRepository

attr_reader :merchants

  def initialize(csv_file_name)
    @merchants = load_from_csv(csv_file_name)
    return self
  end

  def load_from_csv(csv_file_name)
    csv = CSV.read("#{csv_file_name}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Merchant.new(row)
    end
  end

  def find_by_id(search_id)
    search_id = search_id.to_s
    @merchants.find do |merchant|
      search_id == merchant.id
    end
  end

  def find_by_name(search_name)
    search_name = search_name.downcase
    @merchants.find do |merchant|
      name = merchant.name.downcase
      search_name == name
    end
  end

  def find_all_by_name(search_all_name)
    search_all_name = search_all_name.downcase
    @merchants.find_all do |merchant|
      name = merchant.name.downcase
      name.include?(search_all_name)
    end
  end
  
end
