# Following code is ripped off from FeedTools gem, author Bob Aman.

# Original file: lib/feed_tools/helper/html_helper.rb
# Original header:

#--
# Copyright (c) 2005 Robert Aman
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Original comment:
#
# *Shrug*, just brute force it, I guess.  There's a lot of places
# this thing might be hiding in, depending on platform and general
# sanity of the person who installed the thing.  Most of these are
# probably unlikely, but it's not like checking unlikely locations
# hurts.  Much.  Especially if you actually find it.

libtidy_locations = [
  '/usr/local/lib/libtidy.dylib',
  '/opt/local/lib/libtidy.dylib',
  '/usr/lib/libtidy.dylib',
  '/usr/local/lib/tidylib.dylib',
  '/opt/local/lib/tidylib.dylib',
  '/usr/lib/tidylib.dylib',
  '/usr/local/lib/tidy.dylib',
  '/opt/local/lib/tidy.dylib',
  '/usr/lib/tidy.dylib',
  '/usr/local/lib/libtidy.so',
  '/opt/local/lib/libtidy.so',
  '/usr/lib/libtidy.so',
  '/usr/local/lib/tidylib.so',
  '/opt/local/lib/tidylib.so',
  '/usr/lib/tidylib.so',
  '/usr/local/lib/tidy.so',
  '/opt/local/lib/tidy.so',
  '/usr/lib/tidy.so',
  'C:\Program Files\Tidy\tidy.dll',
  'C:\Tidy\tidy.dll',
  'C:\Ruby\bin\tidy.dll',
  'C:\Ruby\tidy.dll',
  '/usr/local/lib',
  '/opt/local/lib',
  '/usr/lib'
]

for path in libtidy_locations
  if File.exists? path
    if File.ftype(path) == "file" || File.ftype(path) == "link"
      Tidy.path = path
      TIDY_ENABLED = true
      break
    elsif File.ftype(path) == "directory"
      # Ok, now perhaps we're getting a bit more desperate
      lib_paths =
        `find #{path} -name '*tidy*' | grep '\\.\\(so\\|dylib\\)$'`
      # If there's more than one, grab the first one and
      # hope for the best, and if it doesn't work, then blame the
      # user for not specifying more accurately.
      tidy_path = lib_paths.split("\n").first
      unless tidy_path.nil?
        Tidy.path = tidy_path
        TIDY_ENABLED = true
        break
      end
    end
  end
end

TIDY_ENABLED = false unless defined? TIDY_ENABLED