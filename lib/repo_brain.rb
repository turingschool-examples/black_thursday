class RepoBrain

  def self.key_by_added_value_hash(records, key, value_to_add)
    records.each_with_object(Hash.new(0)) do |record, hash|
      hash[record.send("#{key}")] += value_to_add
    end
  end

  def self.find_by_id(id, id_type, records)
    records.find do |record|
      record.send("#{id_type}") == id
    end
  end

  def self.find_all_by_id(id, id_type, records)
    records.find_all do |record|
      record.send("#{id_type}") == id
    end
  end

  def self.find_all_by_symbol(symbol, symbol_type, records)
    records.find_all do |record|
      record.send("#{symbol_type}") == symbol.to_sym
    end
  end

  def self.find_by_full_string(string, data_type, records)
    records.find do |record|
      #fix law of demeter violation here
      #need helper method "normalize_string" inside item
      record.send("#{data_type}").downcase == string.downcase
    end
  end

  def self.find_all_by_partial_string(string, data_type, records)
    records.find_all do |record|
      #fix law of demeter violation here
      #need helper method include? inside item
      record.send("#{data_type}").downcase.include?(string.downcase)
    end
  end

  def self.generate_new_id(records)
    highest_id = records.max_by do |record|
      record.id
    end
    highest_id.id + 1
  end
end
