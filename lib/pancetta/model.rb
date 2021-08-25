require "yaml"

require "pancetta/diff"

module Pancetta
  class Model
    def run(linter_type, base_commit)
      linter =
        case linter_type
        when :checkstyle
          require "pancetta/linter/checkstyle"
          Linter::Checkstyle.new
        when :standardrb
          require "pancetta/linter/standardrb"
          Linter::Standardrb.new
        else
          raise "not supported"
        end

      git_diff_out = `git diff #{base_commit} --`
      $stderr.puts git_diff_out, "----"

      diff_blocks = Diff.slice(git_diff_out)
      require "pp"
      $stderr.puts diff_blocks.pretty_inspect, "----"

      linter.run
    end
  end
end
