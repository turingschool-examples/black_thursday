require 'time'

class InvoiceRepository

  def initialize(filepath, engine)
    @records = create_records(filepath)
    @engine = engine
  end

  def all
    @records
  end

  def find_by_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @records.find do |record|
        record.id == id
      end
    end
  end

  def find_all_by_customer_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @records.find_all do |record|
        # require 'pry'; binding.pry
        record.customer_id == id
      end
    end
  end

  def a_valid_id?(id)
    @records.any? do |record| record.id == id
    end 
  end
  
  def a_valid_merchant_id?(id)
    @records.any? do |record| record.merchant_id == id
    end 
  end

  def find_all_by_merchant_id(id)
    if !a_valid_merchant_id?(id)
      return []
    else
      @records.find_all do |record|
        # require 'pry'; binding.pry
        record.merchant_id == id
      end
    end
  end

  def find_all_by_status(status)
      @records.find_all do |record|
        record.status == status
    end
  end

  def create(attribute)
    new_id = @records.last.id + 1
    @records << record.new({:id => new_id, :customer_id => attribute[:customer_id],
      :merchant_id => attribute[:merchant_id],
      :status      => attribute[:attribute],
      :created_at  => Time.now,
      :updated_at  => Time.now}, self)
  end

  def update(id, info)
    @records.each do |record|
      record.update(info) if record.id == id
    end
  end

  def delete(id)
    @records.delete(find_by_id(id))
  end

  def create_records(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_record(contents)
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