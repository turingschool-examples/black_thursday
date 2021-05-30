class MerchantRepository < SalesEngine
attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
    @merchant_instances = []
    CSV.foreach(merchants, headers: true, header_converters: :symbol).each do |row|
      merchant_instances << Merchant.new(row)
       require "pry"; binding.pry
     end
  end

  def find_by_id(id)
    if @merchant_instances.select do |merchant|
      merchant.id.include?(id)
      end
    else
      nil
    end
  end

  # def find_by_name(name)
  #   if @merchant_instances.select do |merchant|
  #     merchant.name.downcase
  #     end
  #   else
  #     nil
  #   end
  # end
  #
  # def find_all_by_name(name)
  #   if @merchant_instances.select do |merchant|
  #     merchant(id)
  #     end
  #   else
  #     nil
  #   end
  # end


end
