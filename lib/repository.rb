require './lib/loader'
# Repositoyr module
module Repository
  def all
    repository
  end

  def find_by_id(id)
    repository.find { |child| child.id == id }
  end

  def find_by_name(name)
    repository.find { |child| child.cascmp == name.casecmp }
  end
end
