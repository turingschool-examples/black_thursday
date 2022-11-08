require './lib/modules/repository_queries'

class InvoiceItemRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
  end

  def all
    @records
  end

  # def find_by_id(id)
  #   if !a_valid_id?(id)
  #     return nil
  #   else
  #     @records.find do |invoice|
  #       invoice.id == id
  #     end
  #   end
  # end

  def a_valid_id?(id)
    @records.any? do |invoice| invoice.id == id
    end 
  end

  def find_all_by_item_id(id)
    @records.find_all do |invoice|
      invoice.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @records.find_all do |invoice|
      invoice.invoice_id == id
    end
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

  # def update(id, attribute)
  #   # require 'pry'; binding.pry
  #   @records.each do |invoice|
  #     invoice.update(attribute) if invoice.id == id
  #     # if invoice.id == id
  #     #   invoice_update = invoice.name.replace(attribute)
  #     #   return invoice_update
  #     # end
  #   end
  # end

  def delete(id)
    @records.delete(find_by_id(id))
  end

  # def create_records(filepath)
  #   contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
  #   make_record_object(contents)
  # end
  
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