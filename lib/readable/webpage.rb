# -*- encoding : utf-8 -*-
require 'net/http'
require 'nokogiri'
require 'sanitize'

module Readable
  class Webpage
    def initialize(url)
      @url = url
    end
    
    def html
      uri = URI.parse(@url)
      result = Net::HTTP.start(uri.host, uri.port) {|http|
        http.get(uri.request_uri)
      }
      
      m        = /charset=(.*?)"/.match(result.body)
      encoding = m[1].downcase rescue 'utf-8'
      if encoding != 'utf-8'
        return result.body.force_encoding(encoding).encode('utf-8')
      else
        return result.body
      end
    end
    
    def doc
      @doc  ||= Nokogiri::HTML(html)
    end
    
    def title
      return @content unless @content.nil?
      
      Rule.rules.each do |rule|
        @title = rule.title(doc)
        return @title unless @title.nil? || @title.strip == ''
      end
      
      %w(h1 h2 h3 h4 h5).each do |h|
        titles = doc.css(h)
        @title = titles.first.text unless titles.empty?
        return @title unless @title.nil? || @title.strip == ''
      end
    end
    
    def content
      return @content unless @content.nil?
      
      Rule.rules.each do |rule|
        @content = rule.content(doc)
        return @content unless @content.nil?
      end
      
      contents = {}
      doc.css('p').each do |p|
        p.parent.css("script").remove
        id  = p.parent.name
        id += "##{p.parent.attributes['id'].value}" if p.parent.attributes["id"]
        id += ".#{p.parent.attributes['class'].value}" if p.parent.attributes["class"]
        contents[id] ||= p.parent.inner_html
      end
      
      @content = ''
      contents.each do |key, content|
        @content = content if Sanitize.clean(content).length > Sanitize.clean(@content).length
      end
      @content
    end
  end
end
