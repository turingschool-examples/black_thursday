class MerchantRepository

  #returns an array of all known Merchant instances
  def all
  end

  #returns either nil or an instance of Merchant with a matching ID
  def find_by_id
  end

  #returns either nil or an instance of Merchant having done a case insensitive search
  def find_by_name
  end

  #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  def find_all_by_name
  end

end