class CustomerRepository

  def initialize(customers, engine)
    @customers  = create_customers(customers)
    @engine     = engine
  end

  ######################################
  #def all
  
  #def find_by_id

  #def find_all_by_first_name

  #def find_all_by_last_name

  #create

  #update

  #delete
  ######################################

  def create_customers(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_customer_object(contents)
  end
  
  def make_customer_object(contents)
    contents.map do |row|
      customer = {
              :id => row[:id].to_i, 
              :first_name => row[:first_name],
              :last_name => row[:last_name],  
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
            }
      Customer.new(customer, self)
    end
  end

end