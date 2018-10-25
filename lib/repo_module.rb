module Repository

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @repository.find do |object|
      object.name.upcase == name.upcase
    end
  end

  def new_highest_id
    all.max_by do |object|
      object.id
    end.id + 1
  end




end
