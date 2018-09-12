module FindAllByMerchantID
  def find_all_by_merchant_id(merchant_id)
    @data_set.values.find_all do |element|
      element.merchant_id == merchant_id
    end
  end
end
