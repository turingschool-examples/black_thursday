require 'requirements'
require 'repository_queries'

class CustomerRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records  = create_records(records)
    @engine   = engine
  end
  
  def find_all_by_first_name(string)
    @records.find_all do |record| 
      record.first_name.downcase.include?(string.downcase)
    end
  end
  
  def find_all_by_last_name(string)
    @records.find_all do |record| 
      record.last_name.downcase.include?(string.downcase)
    end
  end

  def create(attribute)
    new_id = @records.last.id + 1
    @records << Customer.new({:id => new_id, 
                              :first_name => attribute[:first_name],
                              :last_name => attribute[:last_name],
                              :created_at => Time.now.to_s,
                              :updated_at => Time.now.to_s
                            }, self)
  end
  
  def make_record(contents)
    contents.map do |row|
      record = {
              :id => row[:id].to_i, 
              :first_name => row[:first_name],
              :last_name => row[:last_name],  
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      Customer.new(record, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end