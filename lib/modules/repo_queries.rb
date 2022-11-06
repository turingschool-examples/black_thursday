require 'time'
require 'csv'

module RepoQueries
  def all
    @data
  end

  def find_by_id(id)
    all.find do |data|
      data.id == id
    end
  end

  def find_by_name(name)
    all.find do |data|
      name.casecmp?(data.name)
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def load_data(file)
    return nil unless file
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data << child.new(row, self)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |datum|
      datum.merchant_id == merchant_id
    end
  end

  def sanitized_attributes(attributes)
    {
      name:        attributes[:name],
      description: attributes[:description],
      unit_price:  attributes[:unit_price],
      merchant_id: attributes[:merchant_id],
      status:      attributes[:status]
    }
  end

  def increment_id(datum)
    datum.id = all.max_by do |datum|
      datum.id
    end.id + 1
  end

  def time_stamp(datum)
    return if datum.class == Merchant
    datum.created_at = Time.now
    datum.updated_at = Time.now
  end

  def create(attributes)
    datum = child.new(sanitized_attributes(attributes))
    increment_id(datum)
    time_stamp(datum)
    all << datum
    datum
  end

  def child
    @child
  end

  # def update(id, attributes)
  #   return if attributes.empty?
  #   updated = find_by_id(id)
  #   updated.name = attributes[:name]
  #   updated.description = attributes[:description]
  #   updated.unit_price = attributes[:unit_price]
  #   updated.updated_at = Time.now
  #   updated.status = attributes[:status]
  #
  # end
end
