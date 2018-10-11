
# Actor for cropping png
module Webgalien 
class CropPngActor
  include Celluloid

    def initialize(output_path)
      @output_path = output_path
    end

  def perform(work_future)
    work = work_future.value
    work.shift!

    input_path = work.input[:path] 
    bbox = work.input[:bbox]
    output_path = File.join(@output_path, 'crop-' + work.id + '.png')

    puts "(#{work.id}) cropping capture".green
    system 'convert ' \
      "-crop #{bbox[:w]}x#{bbox[:h]}+#{bbox[:x]}+#{bbox[:y]} " \
      "#{input_path} #{output_path}"

    work.output = { path: output_path }
    work
  end
end
end
