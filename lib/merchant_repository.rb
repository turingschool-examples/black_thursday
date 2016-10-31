require_relative 'repository_functions'


class MerchantRepository
include RepositoryFunctions


def all
  items
end

def find_by_id(id)
  RepositoryFunctions.find_by(merchants, id)
end

def find_by_name(name)
  RepositoryFunctions.find_by(merchants, name)
end

def find_all_by_name(name)
  RepositoryFunctions.find_all(merchants, name)
end


end
