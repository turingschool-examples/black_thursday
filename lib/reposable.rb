module Reposable
  def class_name
    Object.const_get(self.class.name.chomp('Repository'))
  end

  def create(attributes)
    stuff = {:name        => attributes[:name],
            :id           => next_id,
            :description  => attributes[:description],
            :unit_price   => attributes[:unit_price],
            :created_at   => attributes[:created_at],
            :updated_at   => attributes[:updated_at],
            :merchant_id  => attributes[:merchant_id]}
            
    all.push(class_name.new(stuff))
  end

  def next_id
    if all.empty?
      1
    else
      all.last.id + 1
    end
  end
  
  def find_by_id(id)
    all.find do |entry|
      entry.id == id.to_i
    end
  end

  def update(id,attributes)
    attributes.each do |att,val|
      case att
      when :name
        find_by_id(id).name = val
      when :description
        find_by_id(id).description = val
      when :unit_price
        find_by_id(id).unit_price = val
      end
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end