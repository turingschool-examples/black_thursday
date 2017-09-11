class SalesEngine
    attr_reader :merchant_csv, :item_csv
    
    #do we need this?
    # def initialize() 
    #     @merchant_csv 
    #     @item_csv
    # end 
    
    def from_csv(hash = {})
        @merchant_csv = hash[:merchant]
        @item_csv = hash[:item]
        #take in the path data for our merchant and item csvs in a hash/create instances of both repos
    end 

    def merchants
        #could be instance variable 
        #create or access the merchant repo. Want mr to initialize by processing csv.
        mr = MerchantRepository.new(@merchant_csv)
        #access instance variable to populate mr with merchants
        
        #output: a functioning merchant repo w/ all merchant objects. 
    end 

    def items

    end 
end 