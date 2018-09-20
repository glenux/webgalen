
module Webgalien 
  class Screenshot 
    def self.start(urls:, output_path:)
      # Start workpools
      cores = Celluloid.cores
      screenshot_pool = ScreenshotActor.pool(
        size: cores, 
        args: { output_path: output_path }
      )
      crop_pool = CropPngActor.pool(
        size: cores, 
        args: { output_path: output_path }
      )

      futures = 
        urls.
        map do |url| 
          Celluloid::Future.new { Work.new(input: {url: url}, id: url) }
        end.
        map do |future_work|
          screenshot_pool.future.perform(future_work)
        end.
        map do |future_work|
          crop_pool.future.perform(future_work)
        end 

      puts '(main) Waiting for remaining jobs'
      results = futures.map { |future_work| future_work.value }

      puts '(main) Cleaning'
      results
        .map { |result| result.shift!.artefacts }
        .flatten
      #.select { |artefact| artefact[:type] == :file }
      #.each { |file| FileUtils.rm_f file }

    end
  end
end
