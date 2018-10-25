module Repository

  def all
    @repo_array
  end

  def find_by_id(id)
    @repo_array.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @repo_array.find do |object|
      object.name.upcase == name.upcase
    end
  end

  def new_highest_id
    all.max_by do |object|
      object.id
    end.id + 1
  end

end
