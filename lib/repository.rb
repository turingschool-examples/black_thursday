

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
    @data.find_all do |datum|
      datum.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    datum = find_by_id(id)
    @data.delete(datum)
  end
end
