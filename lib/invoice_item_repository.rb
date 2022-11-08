require 'requirements'
require 'repository_queries'

class InvoiceItemRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
  end

  def create(attribute)
    new_record = @records.last.id + 1
    @records << InvoiceItem.new({:id => new_record, 
      :item_id => attribute[:item_id],
      :invoice_id => attribute[:invoice_id],
      :quantity => attribute[:quanity],
      :unit_price => attribute[:unit_price],
      :created_at => attribute[:created_at].to_s,
      :updated_at => attribute[:updated_at].to_s
      }, self)
  end

  def make_record(contents)
    contents.map do |row|
      record = {
              :id => row[:id], 
              :item_id => row[:item_id],
              :invoice_id => row[:invoice_id],
              :quantity => row[:quantity],
              :unit_price => row[:unit_price],
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      InvoiceItem.new(record, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end