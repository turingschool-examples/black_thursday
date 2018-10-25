module Repository
  
  def all
    @collection
  end
  
  def find_by_id(id)
    all.find do |thing|
      thing.id == id
    end
  end
  
  def find_by_name(name)
    all.find do |thing|
      thing.name.upcase == name.upcase
    end
  end
  
  def delete(id)
    thing = find_by_id(id)
    all.delete(thing)
  end
  
  def max_id
    max_id = all.max_by do |thing|
      thing.id
    end
    max_id.id
  end
  
  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end
  
end