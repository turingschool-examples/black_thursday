module RepositoryHelper

  def find_by_id(id)
    @all.find do|object|
      id == object.id
    end
  end
  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |object|
      object.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    @all.max_by do |object|
      object.id
    end
  end
end
