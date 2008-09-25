require 'test/unit'
require 'rubygems'
require 'active_support'
require 'init'

class StringTidyTest < Test::Unit::TestCase

  def test_string_extension
    assert_equal "<p>blah</p>", "<p>blah".tidy
  end

  def test_string_extension_takes_options
    assert_equal 'blah', '<font color="red">blah</font>'.tidy(:drop_font_tags => true)
  end

end
