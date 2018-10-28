require_relative './repo_module'
require_relative './customer'

class CustomerRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Customer
    @all = from_csv(file_path)
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |name|
      name.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |name|
      name.last_name.downcase.include?(last_name.downcase)
    end
  end

  def create(attributes)
    highest_object = @all.max {|object| object.id}
    attributes[:id] = highest_object.id + 1
    attributes[:first_name] = attributes[:first_name]
    attributes[:last_name] = attributes[:last_name]
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.now.to_s
    @all << @class_name.new(attributes)
  end

  def update(id, attributes)
    object = find_by_id(id)
    object.first_name = attributes[:first_name].to_s if attributes[:first_name]
    object.last_name = attributes[:last_name].to_s if attributes[:last_name]
    object.updated_at = Time.new.getutc if object
  end
end
