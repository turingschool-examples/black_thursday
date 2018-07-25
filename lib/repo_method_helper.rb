module RepoMethodHelper

  def find_by_id(id_number)
    all.find do |each|
      each.id.to_i == id_number
    end
  end

end
