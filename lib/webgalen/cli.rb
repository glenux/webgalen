
require 'table_print'

module Webgalen 
  class Cli < Thor 
    class_option :'user-agent',
      aliases: '-ua',
      banner: 'USER-AGENT',
      type: :string,
      desc: 'choose user agent (default Mozilla)'
    option :output,
      aliases: '-o',
      banner: 'OUTPUT-FILE',
      type: :string,
      default: 'sitemap.yml',
      desc: 'where sitemap will be produced (default: sitemap.yml)'

    desc 'sitemap URL FILE', 'crawl site and export sitemap'
    def sitemap url
      Sitemap.start(
        url: url,
        output: options['output']
      )
    end

    desc 'screenshot FILE', 'take screenshots for each page'
    option :device, 
      aliases: '-d',  
      banner: 'DEVICE',
      type: :string,
      desc: 'set device from "list-devices" (default "desktop")'
    option :profile, 
      aliases: '-r',  
      banner: '[portrait|landscape]',
      type: :string,
      desc: 'choose device orientation (default "portrait")'
    option :"output-path",
      aliases: '-o',
      banner: 'OUTPUT-PATH',
      type: :string,
      default: 'cache',
      desc: 'directory where resulting content will be produced'

    def screenshot sitemap
      if not Devices.exist?(options['device']) then
        STDERR.puts "ERROR: device #{options['device']} does not exist"
        exit 1
      end
      Screenshot.start(
        sitemap: sitemap, 
        output_path: options['output-path'],
        device: options['device'],
        orientation: options['orientation']
      )
    end


    desc 'list-devices', 'list available profiles'
    def list_devices
      # from https://mediag.com/news/popular-screen-resolutions-designing-for-all/
      Devices.display_list
    end
  end
end
