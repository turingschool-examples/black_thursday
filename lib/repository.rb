class Repository
  def initialize
    @data = []
  end

  def all
    @data
  end

  def find_by_id(id)
    @data.find do |datum|
      datum.id == id
    end
  end

  def find_by_name(name)
    @data.find do |datum|
      datum.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    datum = find_by_id(id)
    @data.delete(datum)
  end

  def inspect
   "#<#{self.class} #{@data.size} rows>"
  end

end
