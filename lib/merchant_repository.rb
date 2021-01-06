class MerchantRepository
  attr_reader :data


  def initialize(data)
    @data = data
    @merchant_info = populate_repo
  end

  def populate_repo
    merchant = Hash.new{|h,k| h[k] = []}
    merchant_data = CSV.open @data, headers: true, header_converters: :symbol
    merchants = merchant_data.map do |row|
        merchant[row[:id]] = Merchant.new({:id => row[:id],
                                         :name => row[:name]})
    end
    merchant
  end

  def all
    @merchant_info
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant[0] == id.to_s
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant[1].name.upcase == name.upcase
    end
  end

  # def find_all_by_name(search_string)
  #   all.find_all do |key, value|
  #     value.name.upcase.include?(search_string.upcase)
  #   end
  # end

  # def max_id
  #   all.max_by do |key, record|
  #     record.id
  #   end
  # end
  #
  # def new_id
  #   max_id[0].to_i + 1
  # end

  # def create(new_name)
  #   @merchant_info[:new_id.to_s] = Merchant.new({:id => new_id.to_s, :name => new_name})
  # end

  # def update(id, new_name)
  #   @merchant_info[id] = Merchant.new({:id => id, :name => new_name})
  # end

  # def delete(id)
  #   @merchant_info.delete_if do |key, value|
  #     key == id
  #   end
  # end

end
