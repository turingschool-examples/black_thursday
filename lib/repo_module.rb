module Repo


  def find_by_id(id)
    all.find do |thing|
      thing.id == id
    end
  end


end
