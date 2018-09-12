class MerchantRepo < CsvAdaptor

    attr_reader :merchants,
                :data_file

  def initialize(data_file)
    @data_file = data_file
    @merchants = []
  end

  def all_merchant_characteristics(data_file)
    load_merchants(data_file)
  end

  def all
    # load_merchants(data_file).each do |merchant_info|
    #   @merchants << Merchant.new(merchant_info)
    # end
    @merchants
  end

  def load_all_merchants
    load_merchants(data_file).each do |merchant_info|
      @merchants << Merchant.new(merchant_info)
    end
  end

  # def find_by_id(id)
  #   @merchants.inject([]) do |array, merchant|
  #     if merchant.id == id
  #       merchant
  #     end
  #   end
  #   # nil
  # end

  def find_by_id(id)
    @merchants.each do |merchant|
      if merchant.id == id
        return merchant
      end
    end
    nil
  end

  def find_by_name(name)
    @merchants.inject(Merchant) do |merchants, merchant|
      if merchant.name.downcase == name.downcase
        return merchant
      else
      end
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end

  def find_highest_merchant_id
    m = @merchants.max_by do |merchant|
      merchant.id
    end
    m.id
  end

  def create(attributes)
    merchant = Merchant.new(attributes)
    merchant.create_id(find_highest_merchant_id + 1)
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    new_name = attributes[:name]
    merchant.change_name(new_name)
    merchant.change_updated_at
    merchant
  end

  def delete(id)
    @merchants.delete_if do |merchant|
      merchant.id == id
    end
  end
end
