require 'csv'
require 'time'
require_relative 'customer'
require_relative 'helper_methods'

class CustomerRepository
  include HelperMethods
  attr_reader :all, :engine

  def initialize(file_path, engine)
    @file_path = file_path.to_s
    @engine = engine
    @all = Array.new
    create_items
  end

  def create_items
    data = CSV.parse(File.read(@file_path), headers: true, header_converters: :symbol) do |line|
      @all << Customer.new(line.to_h, self)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_first_name(name_frag)
    result = all.select do |line|
      line.first_name.to_s.downcase.include?(name_frag.to_s.downcase)
    end
  end

  def find_all_by_last_name(name_frag)
    result = all.select do |line|
      line.last_name.to_s.downcase.include?(name_frag.to_s.downcase)
    end
  end

  def create(attributes)
    @all << Customer.new(
      {
        :id => create_new_id,
        :first_name => attributes[:first_name],
        :last_name => attributes[:last_name],
        :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at],
      }, self
    )
  end

  def update(id, attributes)
    result = find_by_id(id)
    unless result == nil
      @all.delete(result)
      result.first_name = attributes[:first_name] if attributes[:first_name] != nil
      result.last_name = attributes[:last_name] if attributes[:last_name] != nil
      #may require modification (doesn't currently align with #InvoiceItemRepository.initialize)
      result.updated_at = Time.now
      @all << result
    end
  end

end
