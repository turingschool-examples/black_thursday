class MerchantRepo < CsvAdaptor

    attr_reader :merchants

  def initialize(data_file)
    @data_file = data_file
    @merchants = []
  end

  def all_merchant_characteristics
    load_merchants
  end

  def create_array_of_merchant_objects

  end

  def all
    load_merchants.each do |merchant_info|
      @merchants << Merchant.new(merchant_info)
    end
    @merchants
  end

  def find_by_id(id)
    @merchants.each do |merchant|
      if merchant.id == id
        return merchant
      else
        nil
      end
    end
  end

  # def find_by_name(name)
  #   holder = @merchants.map do |merchant|
  #     if merchant.name == name
  #       merchant
  #     end
  #   end
  #   holder.compact
  # end

  def find_by_name(name)
    @merchants.each do |merchant|
      if merchant.name == name
        return merchant
      end
    end
    nil
  end

end
