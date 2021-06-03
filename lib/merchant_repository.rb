class MerchantRepository
  attr_reader :all

  def initialize(path)
    @path = path
    @all = generate
  end

  def generate
    CSV.readlines(@path).drop(1).map do |line|
      id,name,created_at,updated_at = line
      Merchant.new({
          :id => id.to_i,
          :name => name,
          :created_at => created_at,
          :updated_at => updated_at
          })
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end
end
