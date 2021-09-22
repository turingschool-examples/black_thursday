require_relative './sales_engine'

class MerchantRepository
  attr_reader :all

  def initialize(merchant_path)
    @all = (
      merchant_objects = []
      CSV.foreach(merchant_path, headers: true, header_converters: :symbol) do |row|
        merchant_objects << Merchant.new(row)
      end
      merchant_objects)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    if (@all.any? do |merchant|
      merchant.id == id
    end) == true
      @all.find do |merchant|
        merchant.id == id
      end
    else
      nil
    end
  end

  def find_by_name(name)
    if (@all.any? do |merchant|
      merchant.name.upcase == name.upcase
    end) == true
      @all.find do |merchant|
        merchant.name.upcase == name.upcase
      end
    else
      nil
    end
  end

  def create(attributes)
    new_merchant = Merchant.new(attributes)
    @all << new_merchant
  end

  def update(id, new_name)
    if find_by_id(id) != nil
      (find_by_id(id).name.clear.gsub!("", new_name))
    end
  end

  def delete(id)
    if find_by_id(id) != nil
      @all.delete(@all.find do |merchant|
        merchant.id == id
      end)
    end
  end
end
