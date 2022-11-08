require_relative 'requirements'

class MerchantRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
    # @engine = engine
  end
  
  def create(attribute)
    new_id = @records.last.id + 1
    @records << Merchant.new({:id => new_id, :name => attribute}, self)
  end

#  def update(id, attributes)
#     record = self.find_by_id(id)
#     record.update(attributes)
#   end

  def make_record(contents)
    contents.map do |row|
      info = {:id => row[:id], :name => row[:name]}
      Merchant.new(info, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@records.size} rows>"
  end
end