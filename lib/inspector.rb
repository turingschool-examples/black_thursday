module Inspector

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

  def create(attributes)
    attributes[:id] = @all.max{|item| item.id.to_i}.id + 1
    @all << (@all.first.class).new(attributes)
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

end
