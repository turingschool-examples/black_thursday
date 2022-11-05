module RepoQueries
  def all
    @data
  end

  def find_by_id(id)
    all.find do |data|
      data.id == id
    end
  end    

  def find_by_name(name)
    all.find do |data|
      name.casecmp?(data.name)
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def load_data(file)
    return nil unless file
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data << child.new(row, self)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |datum|
      datum.merchant_id == merchant_id
    end
  end
end
