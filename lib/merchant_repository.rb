class MerchantRepository

  def initialzie(merchant_data, parent)
    @merchant_repo = merchant_data.map {|merchant| Merchant.new(merchant, self)}
    @parent = parent
  end

  def all

  end

end
