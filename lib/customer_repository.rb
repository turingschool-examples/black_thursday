class CustomerRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers: true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Customer.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |customer|
      customer.id.to_i == id.to_i
    end
  end

  def find_all_by_first_name(first_name_fragment)
    all.find_all do |customer|
      customer.first_name.downcase.include?(first_name_fragment.to_s.downcase)
    end
  end

  def find_all_by_last_name(last_name_fragment)
    all.find_all do |customer|
      customer.last_name.downcase.include?(last_name_fragment.to_s.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
