# all - returns an array of all known Customers instances
# find_by_id - returns either nil or an instance of Customer with a matching ID
# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
# The data can be found in data/customers.csv so the instance is created and used like this:
#
# cr = CustomerRepository.new
# cr.from_csv("./data/customers.csv")
# customer = cr.find_by_id(6)
# # => <customer>
