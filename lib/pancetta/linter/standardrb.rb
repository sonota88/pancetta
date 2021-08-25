require "json"

require "pancetta/block"
require "pancetta/issue"

module Pancetta
  module Linter
    class Standardrb
      def run(files)
        file_list = files.join(" ")
        `bundle exec standardrb -f json #{file_list}`
      end

      def target?(path)
        path.end_with?(".rb")
      end

      def parse(raw_output)
        data = JSON.parse(raw_output)

        blocks = data['files'].map do |file_data|
          issues = file_data['offenses'].map do |offense|
            to_issue(offense)
          end

          Block.new(
            File.expand_path(file_data['path']),
            issues
          )
        end

        blocks
      end

      private

      def to_issue(offense)
        Issue.from_plain(
          'message'  => offense['message'],
          'rule'     => offense['cop_name'],
          'line'     => offense['location']['line'],
          'column'   => offense['location']['column'],
          'severity' => offense['severity']
        )
      end
    end
  end
end
