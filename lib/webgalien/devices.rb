require 'csv'

module Webgalien 
  class Devices
    PROFILES_CSV = <<-MARK
      laptop, 1440, 900, computer, "x"
      desktop, 1280, 768, computer, "x"

      apple-iphone-x, 375, 812, phone, "Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1"
      apple-iphone-8plus, 414, 736, phone, "Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1"
      apple-iphone-8, 375, 667, phone, "Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1"
      apple-iphone-7plus, 414, 736, phone
      apple-iphone-7, 375, 667, phone
      apple-iphone-6plus, 414, 736, phone
      apple-iphone-6, 375, 667, phone
      apple-iphone-5, 320, 568, phone
      apple-ipad-pro, 1024, 1366, tablet
      apple-ipad, 768, 1024, tablet
      apple-air, 768, 1024, tablet
      apple-air-2, 768, 1024, tablet
      apple-mini, 768, 1024, tablet
      apple-mini-2, 768, 1024, tablet
      apple-mini-3, 768, 1024, tablet

      samsung-galaxy-s9, 360, 740, phone
      samsung-galaxy-s8plus, 360, 740, phone
      samsung-galaxy-s8, 360, 740, phone
      samsung-galaxy-s7, 360, 640, phone
      nexus-6p, 411, 731, phone
    MARK
    .freeze

    PROFILES = CSV.parse(PROFILES_CSV, skip_blanks: true, quote_char: '"', liberal_parsing: true )
     .map do |model, width, height, type, agent| 
       {
         model: model&.strip,
         width: width&.strip, 
         height: height&.strip, 
         type: type&.strip,
         agent: agent&.strip
       }
     end.freeze

    def self.display_list 
      tp PROFILES
    end

    def self.exist? profile
      require 'pp'
      pp PROFILES
      exit 1
      return PROFILES.map {|x| x.models }.exist? profile
    end
  end
end

