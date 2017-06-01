require_relative 'merchant'
class MerchantRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def populate_merchants(line)
    return false if line == "id,name,created_at,updated_at\n"
    columns = line.split(",")
      id = columns[0]
      name = columns[1]
    self.all << Merchant.new({ :name => name, :id => id })
  end

  def find_by_id(id)
    @all.find do |merchant|
      if merchant.id == id
        return merchant
      end
      nil
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      if merchant.name.downcase == name.downcase
        return merchant
      end
      nil
    end
  end

  def find_all_by_name(name)
    result = []
    @all.find_all do |merchant|
      if merchant.name.downcase.include? name.downcase
        result << merchant
      end
    end
    result
  end
end
