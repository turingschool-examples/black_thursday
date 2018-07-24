require_relative 'merchant'

module Repository

  def find_by_id(id)
    all.find { |each| each.id == id }
  end

  def find_by_name(name)
    all.find { |each| each.name.downcase == name.downcase }
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  # def create_with_id(attributes)
  #   all << child_class.new(attributes)
  # end
end
