# class Repository
    
#   def parse_data(file)
#     rows = CSV.open file, headers: true, header_converters: :symbol
#     rows.each do |row|
#       new_obj = Item.new(row.to_h)
#       items << new_obj
#     end
#   end

#   def inspect
#     "#<#{self.class} #{@merchants.size} rows>"
#   end
  
# end