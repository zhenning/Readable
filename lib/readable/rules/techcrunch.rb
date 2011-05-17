module Readable
  class Techcrunch < Rule
    def title(doc)
      doc.css('div.post_header a').inner_text
    end
  end
  
  Rule.register(Techcrunch.new)
end