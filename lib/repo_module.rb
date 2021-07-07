module RepoModule

  def all
    @repo
  end

  def find_by_id(id_number)
    @repo.find do |element|
      element.id == id_number
    end
  end

  def find_by_name(name)
    @repo.find do |element|
      element.name.downcase == name.downcase
    end
  end

  def delete(id)
    @repo.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(id)
    @repo.find_all do |element|
      element.merchant_id == id
    end
  end

  def inspect
  "#<#{self.class} #{@merchant.size} rows>"
  end

end
