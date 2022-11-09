require 'requirements'

class MerchantRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
    @engine = engine
  end
  
  def create(attributes)
    new_id = @records.last.id + 1
    @records << Merchant.new({:id => new_id, :name => attributes[:name]}, self)
  end

  def make_record(contents)
    contents.map do |row|
      info = {:id => row[:id], 
              :name => row[:name],
              :created_at => row[:created_at]}
      Merchant.new(info, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@records.size} rows>"
  end
end