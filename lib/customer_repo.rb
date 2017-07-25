class CustomerRepository

  # The CustomerRepository is responsible for holding and searching our Customers instances. It offers the following methods:
  def all
    # returns an array of all known Customers instances
  end

  def find_by_id
    # find_by_id - returns either nil or an instance of Customer with a matching ID
  end

  def find_all_by_first_name
    # find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
  end

  def find_all_by_last_name
    # find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
  end

end
