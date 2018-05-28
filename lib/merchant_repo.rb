require './lib/merchant'

class MerchantRepo
  attr_reader :merchants_csv,
              :all

  def initialize(merchants_csv)
    @merchants_csv = merchants_csv
    @all = []
  end

  def load_merchants(csv)
    csv.each do |merchant|
      @all << Merchant.new(merchant)
    end
  end

  def find_by_id(merchant_id)
    @all.find do |merchant|
      merchant.id.to_i == merchant_id
    end
  end

  def find_by_name(merchant_name)
    @all.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(merchant_name)
    output = @all.find_all do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
    output
  end

  def create(attributes)
    new_id = @all.max_by do |merchant|
      merchant.id
    end.id.to_i + 1
    attributes[:id] = new_id
    @all << Merchant.new(attributes)
  end

  def update(id, new_name)
    merchant = self.find_by_id(id)
    merchant.name = new_name
  end

  def delete(id)
    @all.delete_if do |merchant|
      merchant.id.to_i == id
    end
  end

end






