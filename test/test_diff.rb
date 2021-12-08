require_relative "helper"

require "pancetta/diff"

class TestDiff < Minitest::Test

  def test_extract_path_normal
    lines = to_lines(<<~BLOCK)
      --- a/path/to/foo.rb
      +++ b/path/to/foo.rb
    BLOCK

    path = ::Pancetta::Diff.extract_path(lines)

    assert_equal("path/to/foo.rb", path)
  end

  def to_lines(text)
    text.lines.to_a.map(&:chomp)
  end

end
