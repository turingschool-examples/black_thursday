class CustomerRepository

  attr_reader :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
  end

end
