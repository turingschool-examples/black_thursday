module RepositoryQueries

  def all
    @records
  end
  
  def find_by_id(id)
    nil if !a_valid_id?(id)

    @records.find do |record|
      record.id == id
    end
  end

  def a_valid_id?(id)
    @records.any? do |record| record.id == id
    end
  end

  def find_by_name(name)
    @records.find{|record| record.name.downcase == name.downcase}
  end

   def find_all_by_name(string)
    @records.find_all do |record|
      record.name.downcase.include?(string.downcase)
    end
  end

  def find_all_with_description(string)
    @records.find_all do |record|
      record.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(price)
    @records.find_all do |record|
      record.unit_price == price.to_f
    end
  end

  def find_all_by_price_in_range(low, high)
    @records.find_all do |record|
      record.unit_price >= low.to_f && record.unit_price <= high.to_f
    end
  end
  
  def find_all_by_merchant_id(id)
    @records.find_all do |record|
      record.merchant_id == id.to_i
    end
  end

  def create_records(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_record(contents)
  end

  def delete(id)
    @records.delete(find_by_id(id))
  end
  
end