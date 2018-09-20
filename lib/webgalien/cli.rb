
module Webgalien 
  class Cli < Thor 
    class_option :'user-agent',
      aliases: '-ua',
      banner: 'USER-AGENT',
      type: :string,
      desc: 'choose user agent (default Mozilla)'

    desc 'sitemap URL FILE', 'crawl site and export sitemap'
    def sitemap url, file 
    end

    desc 'screenshot FILE', 'take screenshots for each page'
    option :profile, 
      aliases: '-p',  
      banner: 'PROFILE',
      type: :string,
      desc: 'choose device profile / resolution (default 1440x900 on desktop pc)'
    option :output,
      aliases: '-o',
      banner: 'OUTPUT-DIRECTORY',
      type: :string,
      default: '.',
      desc: 'where resulting content will be produced'

    def screenshot file
      config = YAML.load File.open(file)
      prefixed_urls = config['pages'].map {|u| config['root'] + u }

      Screenshot.start(
        urls: prefixed_urls,
        output_path: options['output']
      )
    end
  end
end
