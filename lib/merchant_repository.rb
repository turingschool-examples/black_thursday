require_relative '../merchant'
class MerchantRepository
  attr_reader :list_of_merchants,
              :parent_engine

  def initialize(merchants_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_merchants = populate_merchants(merchants_data)
  end

  def populate_merchants(merchants_data)
    merchants_data.map do |datum|
      Merchant.new(datum, self)
    end
  end

  def all
    list_of_merchants
  end

  def find_by_id(id_to_find)
    @list_of_merchants.find do |merchant|
      merchant.id == id_to_find.to_s
    end
  end

  def find_by_name(name_to_find)
    @list_of_merchants.find do |merchant|
      merchant.name.downcase == name_to_find.downcase
    end
  end

  def find_all_by_name(name_fragment_to_find)
    @list_of_merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment_to_find.downcase)
    end
  end

  def pass_to_engine(id)
    parent_engine.find_items(id)
  end

end
