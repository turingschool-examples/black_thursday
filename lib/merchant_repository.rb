class MerchantRepository
  attr_reader :data,
              :all

  def initialize(data)
    @data = data
    @all = populate_repo
  end

  def populate_repo
    merchant_data = CSV.open @data, headers: true, header_converters: :symbol
    merchants = merchant_data.map do |row|
        Merchant.new({:id => row[:id], :name => row[:name]})
    end
    merchants
  end

  def max_id
    @all.max_by do |record|
      record.id
    end
  end

  def new_id
    max_id.id.to_i + 1
  end

  def create(new_name)
    @all << Merchant.new({:id => new_id.to_s, :name => new_name})
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id.to_s
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

end
