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

    def update(id, attributes)
      if find_by_id(id) != nil
        update_attributes(id, attributes)
        if find_by_id(id).updated_at != nil
          find_by_id(id).updated_at = Time.now
        end
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
          if key == :credit_card_number
            find_by_id(id).status = attributes[:credit_card_number]
          end
          if key == :credit_card_expiration_date
            find_by_id(id).status = attributes[:credit_card_expiration_date]
          end
          if key == :result
            find_by_id(id).status = attributes[:result]
          end
          if key == :quantity
            find_by_id(id).status = attributes[:quantity]
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
