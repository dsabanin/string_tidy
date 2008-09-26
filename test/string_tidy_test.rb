require 'test/unit'
require 'rubygems'
require 'active_support'
require 'init'

class StringTidyTest < Test::Unit::TestCase

  def setup
    @unicode_string = "\320\277\321\200\320\270\320\262\320\265\321\202 \320\264\321\200\321\203\320\267\321\214\321\217"
    @unicode_string_with_broken_tags = "<p>#{@unicode_string}<br /> <img alt='\320\264\321\200\321\203\320\267\321\214\321\217' src='http://google.com/logo.png'"
  end
  
  def test_string_extension
    assert_equal "<p>blah</p>", "<p>blah".tidy
  end

  def test_string_extension_takes_options
    assert_equal 'blah', '<font color="red">blah</font>'.tidy(:drop_font_tags => true)
  end
  
  def test_unicode_string_tidy
    assert_equal @unicode_string, @unicode_string.tidy
    expect = "<p>\320\277\321\200\320\270\320\262\320\265\321\202 \320\264\321\200\321\203\320\267\321\214\321\217<br />\n<img alt='\320\264\321\200\321\203\320\267\321\214\321\217' src='http://google.com/logo.png' /></p>"
    assert_equal expect, @unicode_string_with_broken_tags.tidy
  end

end
