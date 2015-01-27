module RFlags
  class FileFlag
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def set?
      File.file?(path)
    end

    def set
      File.write(path, '')
    end

    def reset
      File.delete(path) if File.file?(path)
    end
  end
end
