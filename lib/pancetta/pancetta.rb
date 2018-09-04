# coding: utf-8

require "json"
require "yaml"

require "pancetta/diff"
require "pancetta/block"
require "pancetta/issue"

module Pancetta
  class Pancetta
    def run(base_commit)
      require "pancetta/linter/rubocop"
      linter = Linter::Rubocop.new

      require "pancetta/formatter/default"
      formatter = Formatter::Default.new

      git_diff_out = `git diff #{base_commit} --`

      diff_blocks = Diff.slice(git_diff_out)

      diff_map = {}
      diff_blocks.each do |lines|
        path = Diff.extract_path(lines)
        if linter.target?(path)
          diff_map[path] = Diff.extract_ranges(lines)
        end
      end

      target_files = diff_map.keys

      raw_output = linter.generate(target_files)

      blocks = linter.parse(raw_output)

      # ファイル内での絞り込み
      filtered_blocks =
        blocks
        .map { |block| select_modified(block, diff_map) }
        .reject { |block| block.issues.empty? }

      unless filtered_blocks.empty?
        formatted = formatter.format(base_commit, filtered_blocks)
        print formatted
        exit 1
      end
    end

    private

    def rel_path(path, wd)
      path[wd.size + 1 .. -1]
    end

    def select_modified(block, diff_map)
      rel_path = rel_path(block.path, Dir.pwd)

      modified_issues = block.issues.select do |issue|
        if diff_map.key?(rel_path)
          if diff_map[rel_path].any? { |dr| dr.include?(issue.line) }
            # 変更差分に含まれる
            true
          else
            # 変更差分に含まれない
            false
          end
        else
          # 変更差分に含まれない
          # ファイルを指定せずに全体を対象にした場合にこのパターンが発生する
          false
        end
      end

      Block.new(rel_path, modified_issues)
    end
  end
end
