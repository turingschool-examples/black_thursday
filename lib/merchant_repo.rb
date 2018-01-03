require_relative 'merchant'

class MerchantRepo
  attr_reader :data, :parent

  include CreateElements

  def initialize(data, parent)
    @data = create_elements(data).reduce(Hash.new(0)) do |merchant_collection, merchant|
      merchant_collection[merchant[:id].to_i] = Merchant.new(merchant, self)
    end
    @parent = parent
  end

  def all

  end

  def find_by_id

  end

  def find_by_name

  end

  def find_all_by_name

  end

end
