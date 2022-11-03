module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end

  def next_id
    if all.empty?
      1
    else
      all.last.id.to_i + 1
    end
  end
  
  def find_by_id(id)
    all.find do |entry|
      entry.id.to_i == id.to_i
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end