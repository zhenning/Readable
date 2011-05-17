module Readable
  class Rule
    @@rules = []
    
    class << self
      def register(rule)
        @@rules << rule
      end
      
      def rules
        @@rules
      end
    end
    
    def title(doc)
      nil
    end
    
    def content(doc)
      nil
    end
  end
end