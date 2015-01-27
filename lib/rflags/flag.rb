module RFlags
  class Flag
    def initialize
      @state = false
    end

    def set?
      @state
    end

    def reset
      @state = false
    end

    def set
      @state = true
    end
  end
end
