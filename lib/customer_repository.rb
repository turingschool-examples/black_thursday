class CustomerRepository

  attr_reader :sales_engine,
              :file_path,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo      = {}
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      customer_identification = row[:id]
      customer = Customer.new(row, self)
      @id_repo[customer_identification.to_i] = customer
    end
  end

end
