module RepoModule

  def inspect
  "#<\#{self.class} \#{@data.size} rows>"
  end

  def all
    @data
  end

  def find_by_id(number)
    @data.find do |element|
      element.id == number
    end
  end

    def find_by_name(search_name)
      @data.find do |element|
        element.name.downcase == search_name.downcase
      end
    end

    def update_attributes(id, attributes)
        attributes.each do |key, value|
          if key == :name
            find_by_id(id).name = attributes[:name]
          end
          if key == :description
            find_by_id(id).description = attributes[:description]
          end
          if key == :unit_price
            find_by_id(id).unit_price = attributes[:unit_price]
          end
          if key == :status
            find_by_id(id).status = attributes[:status]
          end
        end
    end

    def delete(id)
      @data.delete(find_by_id(id))
    end

    def find_next_id
      if @data == []
        return 1
      else
        max_id = @data.max_by do |element|
          element.id
        end.id
        max_id += 1
      end
    end
end
