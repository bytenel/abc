require "abc/version"

module Abc
  class Gem
    def initialize(name)
      # parse out the name here
      @name = name
    end

    def <=>(other)
      other.name <=> @name
    end
  end

  class Group
    attr_accessor :gems

    def initialize(name)
      # parse out the group name from the match here
      @name = name
      @gems = []
    end

    def <=>(other)
      other.name <=> @name
    end

    def <<(item)
      @gems.push(item)
    end
  end

  def load_gemfile
   group = /group.*do/
   gem = /gem.*/
   @gemfile_lines = []
   File.open('Gemfile', 'r').each_line do |line|
    match = group.match(line)
    if match
      in_group = true
      @gemfile_lines << Group.new(match)
    end

    if /end/.match(line)
      next
    end

    if in_group
      @gemfile_lines.last << Gem.new(gem.match(line))
      in_group = false
    else
      @gemfile_lines << Gem.new(gem.match(line))
    end
   end
  end

  def reorder_gemfile
    @gemfile_lines.sort!
  end

  def save_gemfile
    File.open('NewGemfile', 'w') do |f|
      @gemfile_lines.each do |line|
        f.puts line
      end
    end
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
