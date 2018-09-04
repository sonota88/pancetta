module Pancetta

  class Issue
    attr_reader :severity, :line, :column, :message

    def initialize(severity, line, column, message, rule)
      @severity = severity
      @line     = line
      @column   = column
      @message  = message
      @rule     = rule
    end

    def self.from_plain(hash)
      Issue.new(
        hash["severity"],
        hash["line"],
        hash["column"],
        hash["message"],
        hash["rule"]    
      )
    end

    # def to_plain
    #   {
    #     severity: @severity,
    #     line:     @line,
    #     column:   @column,
    #     message:  @message,
    #     rule:     @rule
    #   }
    # end

    # def to_json(state)
    #   JSON.generate(to_plain, state)
    # end
  end

end
