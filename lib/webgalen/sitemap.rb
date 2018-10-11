
module Webgalen 
  class Sitemap 
    def self.start(url:, output:)
      puts "Loading #{url}"

      visited = Set.new
      remains = Set.new
      remains << url
      root = url

      while remains.size > 0
        current = remains.to_a[0]
        remains.delete(current)

        current2, links = Sitemap.get_links(root, current)
        visited << current2

        remains = 
          remains + links.to_set - visited - visited.map{|x| x.gsub(/\/$/,'') }
      end

      result = { 
        "root" => root,
        "pages" => visited.to_a
      }
      File.write(output, result.to_yaml)
    end


    def self.get_links(root, url) 
      links = []
      mechanize = Mechanize.new
      page = mechanize.get(url)
      url2 = page.uri.to_s 
      
      page.links.each do |link|
        next if ! link.href =~ /^https?:\/\//
        begin 
          link_url = mechanize.resolve(link.href).to_s
          print "Found #{url} -> #{link_url} "
          if link_url.start_with?(root) then
            puts "(ok)".green
            links << link_url
          else 
            puts "(out of scope)".red
          end
        rescue Mechanize::UnsupportedSchemeError
          print "Found #{url} -> #{link.href} "
          puts "(unsupported scheme)".red
        end
      end
      return url2, links
    end
  end
end
