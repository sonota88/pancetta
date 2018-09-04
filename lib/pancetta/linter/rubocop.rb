module Pancetta
  module Linter
    class Rubocop
      def target?(path)
        /\.rb$/ =~ path
      end

      def generate(target_files)
        `bundle exec rubocop -f json #{target_files.join(" ")}`
      end

      def parse(raw_output)
        data = JSON.parse(raw_output)

        blocks = data["files"].map do |file_data|
          issues = file_data["offenses"].map do |offense|
            to_issue(offense)
          end

          Block.new(
            File.expand_path(file_data["path"]),
            issues
          )
        end

        blocks
      end

      private

      def to_issue(off)
        Issue.from_plain(
          "message"  => off["message"],
          "rule"     => off["cop_name"],
          "line"     => off["location"]["line"],
          "column"   => off["location"]["column"],
          "severity" => off["severity"]
        )
      end
    end
  end
end
