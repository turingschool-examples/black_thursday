require 'csv'
require 'time'
require 'bigdecimal'

module RepoModule

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def from_csv(file_path)
    raw_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_data.map do |row|
      @class_name.new(row.to_h)
    end
  end

  def find_by_id(id)
    @all.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def create(attributes)
    highest_object = @all.max {|object| object.id}
    attributes[:id] = highest_object.id + 1
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.now.to_s
    @all << @class_name.new(attributes)
  end

  def update(id, attributes)
    object = find_by_id(id)
    object.name = attributes[:name] if attributes[:name]
    object.unit_price = attributes[:unit_price] if attributes[:unit_price]
    object.description = attributes[:description] if attributes[:description]
    object.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
    object.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    object.quantity = attributes[:quantity] if attributes[:quantity]
    object.updated_at = Time.new.getutc if object
  end

  def delete(id)
    object = find_by_id(id)
    @all.delete(object)
  end

end
