class MerchantRepository

  def initialize(merchants)
    @merchants = merchants
    
  end
  
  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find_all do |merchant|
      if merchant.id == id
        return merchant
      else @merchants.empty?
        return nil
      end
    end
  end
  
  def find_by_name(name)
      @merchants.find{|merchant| merchant.name == name}
    end


  def update(id, name)
    @merchants.each do |merchant|
      if merchant.id == id
        merchant_new_name = merchant.name.replace(name)
        return merchant_new_name
      end
    end
  end

  def delete(id)
  @merchants.each do |merchant|
    old_id = merchant.id
    if merchant.id == id
      @merchants.delete(old_id)
    end
  end
end
end