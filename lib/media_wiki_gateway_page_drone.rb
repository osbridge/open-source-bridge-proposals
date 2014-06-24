class MediaWikiGatewayPageDrone
  attr_accessor :wiki
  attr_accessor :page
  attr_accessor :content
  attr_accessor :original_content
  attr_accessor :page_title

  def initialize(wiki, title)
    self.page_title = title
    self.wiki = wiki
    #self.page = self.wiki.page(title)
    self.content = self.wiki.get(title) || ''
    self.original_content = self.content.clone
  end

  def save(verbose=false)
    if self.modified?
      self.original_content = self.content.clone
      puts "Saved: #{self.page_title}" if verbose
      return self.wiki.edit(self.page_title, self.content)
    else
      return false
    end
  end

  def append(*strings)
    strings = strings.flatten
    strings.each do |string|
      unless self.content.include?(string)
        self.content << "#{string}\n"
      end
    end
  end

  def replace(pattern, string)
    if self.content.match(pattern)
      return self.content.gsub!(pattern, string)
    else
      return self.append(string)
    end
  end

  def replace_span(identifier, string)
    doc = Nokogiri::HTML(self.content)
    element = doc.css("span##{identifier}")
    if element.size == 0
      self.append(%{<span id="#{identifier}">#{string}</span>})
    else
      element.first.inner_html = string
      self.content = doc.to_s
    end
  end

  def modified?
    return content != original_content
  end

end
