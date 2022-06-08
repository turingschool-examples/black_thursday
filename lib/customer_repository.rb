require_relative 'entry'
class CustomerRepository

  attr_reader :id, :created_at, :all

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(
        :id => row[:id],
        :first_name => row[:first_name],
        :last_name => row[:last_name],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      )
      end
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id.to_i == id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_first_name(fragment)
    @all.find_all do |customer|
      customer.first_name.include?(fragment)
    end
  end

  def find_all_by_last_name(fragment)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end

  def create(attributes)
    x = (@all.last.id.to_i + 1)
    @all << Customer.new({
      :id => x,
      :first_name => attributes[:first_name],
      :last_name => attributes[:last_name],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      })
  end

  def update(id, attributes)
    x = find_by_id(id)
    x.first_name = attributes[:first_name]
    x.last_name = attributes[:last_name]
    x.updated_at = Time.now
  end

  def delete(id)
    x = find_by_id(id)
    @all.delete(x)
  end

end
