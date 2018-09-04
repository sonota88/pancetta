module Pancetta
  class Block
    attr_reader :path, :issues

    def initialize(path, issues)
      @path = path
      @issues = issues
    end

    def self.from_plain(plain)
      path = plain["path"]
      issues = plain["issues"].map do |plain_issue|
        Issue.from_plain(plain_issue)
      end

      Block.new(path, issues)
    end

    def to_plain
      {
        "path" => @path,
        "issues" => @issues.map(&:to_plain)
      }
    end

    def to_json(state)
      JSON.generate(to_plain, state)
    end

    def each_issue
      @issues.each do |issue|
        yield issue
      end
    end
  end
end
