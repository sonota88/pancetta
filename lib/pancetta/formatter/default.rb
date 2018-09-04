# frozen_string_literal: true

module Pancetta
  module Formatter
    class Default
      def format(base_commit, blocks)
        lines = []
        lines << "base commit: #{base_commit}"
        lines << "----"
        lines << ""

        blocks.each do |block|
          lines += format_block(block)
        end

        lines << "----"
        lines << "%d files, %d issues" % [
          blocks.size,
          num_issues(blocks)
        ]

        lines.map{ |line| line + "\n" }.join("")
      end

      private

      def num_issues(blocks)
        n = 0

        blocks.each do |block|
          block.issues.each do |issue|
            n += 1
          end
        end

        n
      end

      def format_block(block)
        lines = []
        lines << "%s (%s)" % [
          File.basename(block.path),
          block.path
        ]

        lines << ""

        block.issues.each do |issue|
          lines << "- %s %d:%d: %s" % [
            issue.severity,
            issue.line,
            issue.column,
            issue.message
          ]
        end

        lines << ""
        lines
      end
    end
  end
end
