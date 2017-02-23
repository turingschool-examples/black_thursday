class MerchantRepository

  def initialize(path)
    @path = path
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all

    # returns an array of all known Merchant instances
  end

  def find_by_id(id)

    #  returns either nil or an instance of Merchant with a matching ID
  end

  def find_by_name(name)

    # returns either nil or an instance of Merchant having done a case insensitive search
  end

  def find_all_by_name

    #  returns either [] or one or more matches which contain the supplied name fragment, case insensitive

  end

end
