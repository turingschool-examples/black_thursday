class CustomerRepository
  attr_reader :customers, :engine

  def initialize(csv_data, engine)
    @engine    = engine
    @customers = csv_data
  end

  def all
    customers
  end

  def find_by_id
    # returns either nil or an instance of Customer with a matching ID
  end

  def find_all_by_first_name
    # returns either [] or one or more matches which have a first name matching the substring fragment supplied
  end

  def find_all_by_last_name
    # returns either [] or one or more matches which have a last name matching the substring fragment supplied
  end

end
