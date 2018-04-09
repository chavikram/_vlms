module VipReferencesHelper
      def get_country (code)
        result=''
        Country.all.each do |(x,y)| 
              if y.eql? code
                result=x
              end      
         end 
         return result
      end
      
      def get_state (country,state)
        result = ''
        CountryStateSelect::CstData.states(country).each do |(x,y)|
            if x.eql? state.to_sym
              result = y
            end
        end
        return result  
      end
end