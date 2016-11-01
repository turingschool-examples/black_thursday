require './lib/merchant'

class MerchantRepository

  def all
    # return array of all known merchant instances
  end

  def find_by_id(id)
    # return either nil or instance of merchant with matching id
  end

  def find_by_name(name)
    # return either nil or instance of merchant having done a case insensitive search
  end

  def find_all_by_name(names)
    # returns either [] or one or more matches that contain the supplied name fragment, case insensitive
  end
end
