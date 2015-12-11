require "abc/version"

module Abc
  class Gem
    def initialize(name)
      # parse out the name here
      @name = name
    end

    def <=>

    end
  end

  class Group
    attr_accessor :gems

    def initialize(name)
      # parse out the group name from the match here
      @name = name
    end

    def <=>

    end
  end

  def load_gemfile
   group = /group.*do/
   gem = /gem.*/
   gemfile_lines = []
   File.open('Gemfile', 'r').each_line do |line|
    match = group.match(line)
    if match
      gemfile_lines << Group.new(match)
    end

    if /end/.match(line)
      next
    end
   gemfile_lines << Gem.new(gem.match(line))
   end
  end

  def reorder_gemfile

  end

  def save_gemfile
    # do the reverse of load with NewGemfile
  end

  def delete_original_gemfile
    File.delete('Gemfile')
    File.rename('NewGemfile','Gemfile')
  end

  def process
    load_gemfile
    reorder_gemfile
    save_gemfile
    delete_original_gemfile
  end
end
