module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end

  def create(attributes)
    new = {  
            :id           => next_id,
            :created_at   => Time.now,
            :updated_at   => Time.now
    }
    attributes.each do |att,val|
      new[att] = val
    end
    all << class_name.new(new)    
  end

  def update(id,attributes)
    entry = find_by_id(id)
  
    entry.updated_at = Time.now if entry.respond_to?(:updated_at=)

    attributes.each do |att,val|
      sym_eq = (att.to_s + "=").to_sym
      entry.send(sym_eq.to_s,val) if entry.respond_to?(sym_eq)
    end
  end

  def next_id
    all.empty? ? 1 : all.last.id.to_i + 1
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