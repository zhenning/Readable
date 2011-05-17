module Readable
  class Sina < Rule
    def title(doc)
      doc.css('h1#artibodyTitle').inner_text
    end
  end
  
  Rule.register(Sina.new)
end