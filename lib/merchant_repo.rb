#all - returns an array of all known Merchant instances
# find_by_id - returns either nil or an instance of Merchant with a matching ID
# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
class MerchantRepo

def add_merchant(data)
  @all << Merchant.new(data, self)
end

def find_by_id(id)
  find_by_id(id)
end

def find_by_name(name)
end

def find_all_by_name(fragment)
end