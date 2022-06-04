module Deletable

  def delete(id)
    @all.delete(find_by_id(id))
  end

end
