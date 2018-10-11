
module Webgalen 
  class Work
    attr_reader :id, :input, :artefacts
    attr_accessor :output

    def initialize(id:, input: )
      @id = id.to_s.gsub(/[^a-zA-Z0-9_-]/, '-')
      @input = input

      @output = nil
      @artefacts = []
    end

    # make pipe ready
    def shift!
      return if @output.nil?
      @artefacts << @input
      @input = @output
      @output = nil
      self
    end
  end
end
