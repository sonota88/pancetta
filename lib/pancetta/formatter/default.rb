module Pancetta
  module Formatter
    class Default
      def format(base_commit, blocks)
        lines = []
        lines << "base commit: #{base_commit}"
        lines << '----'
        lines << ''

        blocks.each do |block|
          block.issues.each do |issue|
            lines << Kernel.format(
              "%s:%d:%d %s %s",
              block.path,
              issue.line,
              issue.column,
              issue.severity,
              issue.message
            )
          end
        end

        lines.map { |line| line + "\n" }.join('')
      end
    end
  end
end
