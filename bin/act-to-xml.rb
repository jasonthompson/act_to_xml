require 'nokogiri'

class HTMLActConverter
  def initialize
    @in_section = false
    @in_subsection = false
    @in_clause = false
    @in_subclause = false
    @in_paragraph = false
  end

  def process_section(node)
    if not(@in_section)
      @in_section = true
      puts %Q{<akn:session>
      #{node.value}}
    else
      puts "</akn:session>"
      @in_section = false
    end
  end

  def convert(doc)
    doc.each do |node|
      case node.attribute('class')
      when "section-e"
        process_section(node)
      end
    end
  end
end

reader = Nokogiri::XML::Reader(File.open('fippa.xhtml'))


converter = HTMLActConverter.new
converter.convert(reader)
