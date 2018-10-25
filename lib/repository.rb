module Repository
  
  def find_by_id(id)
    all.find do |x|
      x.id == id
    end
  end
  
  def find_by_name(name)
    all.find do |x|
      x.name.upcase == name.upcase
    end
  end
  
  def delete(id)
    x = find_by_id(id)
    all.delete(x)
  end
  
end