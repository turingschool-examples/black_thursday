class MerchantRepository
  attr_reader :all

  def initialize(raw_merchant_array)
    @all = raw_merchant_array
  end

  def find_by_id(desired_id)
    all.find { |merchant| merchant.id == desired_id }
  end

  def find_by_name(desired_name)
    all.find { |merchant| merchant.name.downcase == desired_name.downcase }
  end

  def find_all_by_name(desired_name_frag)
    all.find_all do |merchant| 
      merchant.name.downcase.include?(desired_name_frag.downcase)
    end
  end
end