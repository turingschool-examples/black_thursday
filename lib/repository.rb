

class Repository

  def initialize
    @data = []
  end

  def all
    @data
  end

  def find_by_id(id)
    @data.find do |line|
      line.id == id
    end
  end

  def find_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end
