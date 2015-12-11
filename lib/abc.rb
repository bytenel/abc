require "abc/version"

module Abc

  # Steps for ABC
  # Load Gemfile
  # Load each line of the file into a Gem object representing version, title, etc
  # If the line matches a regex with a /do/ block on it then load it into a Block object which has a title
  # representing the symbol of the block
  # the Block object contains Gem objects for each line up to the end statement
  # Organize the gems by name and place the blocks in alphabetical order and organize the blocks by title
end
