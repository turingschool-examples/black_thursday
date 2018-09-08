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

  def create_array_of_merchant_objects

  end

  def all
    load_merchants(data_file).each do |merchant_info|
      @merchants << Merchant.new(merchant_info)
    end
    @merchants
  end

  def find_by_id(id)
    @merchants.each do |merchant|
      if merchant.id == id
        return merchant
      end
    end
    nil
  end

  def find_by_name(name)
    @merchants.each do |merchant|
      if merchant.name == name
        return merchant
      end
    end
    nil
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end

end
