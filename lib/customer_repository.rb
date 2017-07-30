class CustomerRepository
  attr_reader :repository
  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Customer.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    repository[id]
  end


end
