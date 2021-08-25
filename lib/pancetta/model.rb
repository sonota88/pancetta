require "yaml"
require "pp"

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
      # $stderr.puts git_diff_out, "----"

      diff_blocks = Diff.slice(git_diff_out)
      # $stderr.puts diff_blocks.pretty_inspect, "----"

      diff_map = {}
      diff_blocks.each do |lines|
        path = Diff.extract_path(lines)
        if linter.target?(path)
          diff_map[path] = Diff.extract_ranges(lines)
        end
      end
      # $stderr.puts diff_map.pretty_inspect, "----"

      target_files = diff_map.keys

      raw_output = linter.run(target_files)
      # $stderr.puts raw_output

      blocks = linter.parse(raw_output)
      $stderr.puts blocks.pretty_inspect, "----"
    end
  end
end
