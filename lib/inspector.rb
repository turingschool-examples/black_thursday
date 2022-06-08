module Inspector

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

end
