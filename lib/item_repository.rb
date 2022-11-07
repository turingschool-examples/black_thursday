require 'bigdecimal'
require './lib/modules/repository_queries'


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
    created_at: Time.now,
    updated_at: Time.now,
    merchant_id: attributes[:merchant_id]}, 
    self)
  end
  
  def update(id, attributes)
    @records.each do |record|
      if record.id == id
        record.update(attributes)
      end
    end
  end
  
  def create_records(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_record(contents)
  end
  
  def make_record(contents)
    contents.map do |row|
      record = {
              :id => row[:id].to_i, 
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price].to_f,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
              :merchant_id => row[:merchant_id].to_i
            }
      Item.new(record, self)
    end
  end
  
  # def all
  #   @records
  # end
  
  # def find_by_id(id)
  #   nil if !a_valid_id?(id)

  #   @records.find do |record|
  #     record.id == id
  #   end
  # end

  # def a_valid_id?(id)
  #   @records.any? do |record| record.id == id
  #   end
  # end

  # def find_by_name(name)
  #   @records.find{|record| record.name.downcase == name.downcase}
  # end

  # def find_all_with_description(string)
  #   @records.find_all do |record|
  #     record.description.downcase.include?(string.downcase)
  #   end
  # end

  # def find_all_by_price(price)
  #   @records.find_all do |record|
  #     record.unit_price == price.to_f
  #   end
  # end
  
  # def find_all_by_price_in_range(low, high)
  #   @records.find_all do |record|
  #     record.unit_price >= low.to_f && record.unit_price <= high.to_f
  #   end
  # end
  
  # def find_merchant_by_id(id)
  #   @engine.find_by_merchant_id(id)
  # end

  # def find_all_by_merchant_id(id)
  #   @records.find_all do |record|
  #     record.merchant_id == id.to_i
  #   end
  # end

  # def create(attributes)
  #   new_id = @records.last.id + 1
  #   attributes[:id] = new_id
  #   @records << Item.new(attributes, self)
  # end

  # Let's refactor this to use our #find_by_id method
  
  # def delete(id)
  #   @records.delete(find_by_id(id))
  # end

  ##### Generate records
  
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end