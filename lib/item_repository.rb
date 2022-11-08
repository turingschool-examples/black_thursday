require 'requirements'

class ItemRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
    @engine = engine
  end
  
  def create(attributes)
    new_id = @records.last.id + 1
    @records << Item.new({id: new_id, 
    name: attributes[:name],
    description: attributes[:description],
    unit_price: attributes[:unit_price],
    created_at: Time.now.to_s,
    updated_at: Time.now.to_s,
    merchant_id: attributes[:merchant_id]}, 
    self)
  end
  
  def make_record(contents)
    contents.map do |row|
      record = {
              :id => row[:id], 
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price],
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
              :merchant_id => row[:merchant_id]
            }
      Item.new(record, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end