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










#passing in repo instance variable
    def average_items_invoices_per_merchant(repo)
      (repo.all.count.to_f / @merchant_repo.all.count).round(2)
    end

#passing in repo instance variable
    def items_per_merchant_array(repo)
      @merchant_repo.all.map do |merchant|
        repo.all.find_all do |element|
          merchant.id == element.merchant_id
        end.count
      end
    end

    def subtract_square_sum_array_for_items_per_merchant(repo)
      set = items_per_merchant_array(repo)
      average = average_items_invoices_per_merchant(repo)
      new_set = set.map do |element|
        (average - element)**2
      end
      sum(new_set)
    end

    def per_merchant_standard_deviation(repo)
      step_one = subtract_square_sum_array_for_items_per_merchant(repo)
      step_two = step_one/(@merchant_repo.all.count - 1)
      Math.sqrt(step_two).round(2)
    end
end
