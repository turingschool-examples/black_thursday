class MerchantRepository < SalesEngine

  def initialize(merchants)
    @merchants = merchants
    #for each merchant in csv
    @merchant_instances = []
    CSV.foreach(merchants, headers: true, header_converters: :symbol).each do |row|
      @merchant_instances << Merchant.new(row)
       require "pry"; binding.pry
     end
  end

  def find_by_id(id)
    @merchant_instances.select do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchant_instances.select do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchant_instances.select do |merchant|
      if merchant.name.downcase.include?name.downcase.nil?
        []
      else
        merchant.name.downcase.include?name.downcase
      end
    end
  end

  def


end
