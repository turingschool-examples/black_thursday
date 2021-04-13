require 'CSV'

class Repository

  attr_reader :all

  def initialize(csv_filepath)
    @all  = []
    create_repo_array(csv_filepath)
  end

  def create_repo_array(csv_filepath)
    row_objects = CSV.read(csv_filepath, headers: true, header_converters: :symbol)
      @all = row_objects.map do |row|
        new_record(row)
      end
  end

  def find_by_id(id)
    @all.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all.select do |object|
      object.name.upcase.include?(name.upcase)
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |item|
      item.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |item|
      item.invoice_id == invoice_id
    end
  end

  def new_highest_id
    all.max_by do |object|
      object.id
    end.id + 1
  end

  def delete(id)
    index = @all.find_index do |object|
      object.id == id
    end
    return nil if index == nil
    @all.delete_at(index)
  end

  

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
