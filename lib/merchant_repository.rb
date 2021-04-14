# silent hound
require './lib/merchant'
require './lib/repository'
class MerchantRepository < Repository

  def initialize(csv_array)
    super(csv_array)
  end

  def find_all_by_name(name)
    @csv_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(name)
    Merchant.new(id: max_id_number_new,
                 name: name)
  end

  def update(id, name)
    new = find_by_id(id)

    new.name = name
  end

end
