require 'time'
require './lib/modules/repository_queries'

class InvoiceRepository
  include RepositoryQueries

  def initialize(filepath, engine)
    @records = create_records(filepath)
    @engine = engine
  end

  def create(attribute)
    new_id = @records.last.id + 1
    @records << Invoice.new({:id => new_id, 
      :customer_id => attribute[:customer_id],
      :merchant_id => attribute[:merchant_id],
      :status      => attribute[:attribute],
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s}, self)
  end

  def make_record(contents)
    contents.map do |row|
      record = {
              :id => row[:id].to_i, 
              :customer_id => row[:customer_id].to_i,
              :merchant_id => row[:merchant_id].to_i,
              :status => row[:status].to_sym,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      Invoice.new(record, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end