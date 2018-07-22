module RepoHelper

  def all
    @repo
  end

  def find_by_id(id)
    @repo.find do |object|
      id == object.id
    end
  end

  def find_by_name(name)
    @repo.find do |object|
      name.downcase == object.name.downcase
    end
  end


end
