class MerchantRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers:true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id.to_i == id.to_i
    end
  end

  def find_all_by_name(name_fragment)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
