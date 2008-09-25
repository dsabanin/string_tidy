# You need tidy gem for this:
#   gem install tidy or http://rubyforge.org/projects/tidy
# You may also need to install tidy C library:
#   http://tidy.sf.net
require 'tidy'

require 'detect_tidy'
require 'string_tidy'

String.send :include, StringTidy