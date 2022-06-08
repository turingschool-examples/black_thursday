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

end
