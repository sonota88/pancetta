require 'pancetta/diff_range'

module Pancetta
  class Diff
    def self.slice(git_diff_output)
      blocks = []
      buf = []

      git_diff_output.each_line do |line|
        line.chomp!

        if /^diff \-\-git /.match? line
          blocks << buf unless buf.empty?
          buf = [line]
        else
          buf << line
        end
      end

      blocks << buf unless buf.empty?

      blocks
    end

    def self.extract_path(lines)
      re = %r{^\+\+\+ b/(.+)}

      path_line = lines.find { |line| re =~ line }
      if path_line
        re =~ path_line
        return Regexp.last_match(1)
      end
      
      path_line = lines.find { |line| line.start_with?("rename to ") }
      if path_line
        m = path_line.match(/^rename to (.+)/)
        return m ? m[1] : nil
      end

      nil
    end

    def self.extract_ranges(lines)
      re = /^@@ \-(.+?) \+(\d+),(\d+) @@/

      lines
        .select { |line| re =~ line }
        .map { |line|
          re =~ line
          from = Regexp.last_match(2).to_i
          len = Regexp.last_match(3).to_i
          DiffRange.new(from, len)
        }
    end
  end
end
