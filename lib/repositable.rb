
module Repositable

def find_by_id(id)
  @all.find do |source|
    if source.id == id
      return source
    end
  end
end
end
