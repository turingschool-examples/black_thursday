require './lib/merchants_repository'

module RepositoryAide

  def all
    @repository
  end

  # def find(search, result)
  #   require 'pry'; binding.pry
  #   @repository.select do |element|
  #     element.search == result
  #   end
  # end

  def find_by_id(id)
    @repository.find do |element|
      element.id == id
    end
  end

  def new_id
    new_id = @repository.sort_by do |merchant|
                merchant.id
              end.last.id.to_i
    new_id += 1
    # require 'pry'; binding.pry
  end


end
