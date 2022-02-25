
module RepositoryAide

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |element|
      element.id == id
    end
  end

  def new_id
    new_id = @repository.sort_by do |merchant|
                merchant.id.to_i
              end.last.id.to_i
    new_id += 1
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end



end
