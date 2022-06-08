module Inspector

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def delete(id)
    @all.each do |item|
      if item.id == id
        @all.delete(item)
      end
    end
  end

end
