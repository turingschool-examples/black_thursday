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

  def find_all_by_first_name(first_name)
    all.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |customer|
      customer.last_name == last_name
    end
  end


end
