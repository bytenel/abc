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

  def self.load_gemfile
   group = /group.*do/
   gem = /(?!gemspec)gem.*/
   @gemfile_lines = []
   File.open('Gemfile', 'r').each_line do |line|
    match = group.match(line)
    if match
      in_group = true
      @gemfile_lines << Abc::Group.new(match)
    end

    if /end/.match(line)
      next
    end

    if in_group
      @gemfile_lines.last << Abc::Gem.new(gem.match(line))
      in_group = false
    elsif gem.match(line)
      @gemfile_lines << Abc::Gem.new(gem.match(line))
    end
   end
  end

  def self.reorder_gemfile
    @gemfile_lines.sort!
  end

  def self.save_gemfile
    File.open('NewGemfile', 'w') do |f|
      @gemfile_lines.each do |line|
        f.puts line
      end
    end
  end

  def self.delete_original_gemfile
    File.delete('Gemfile')
    File.rename('NewGemfile','Gemfile')
  end

  def self.process
    load_gemfile
    reorder_gemfile
    save_gemfile
    delete_original_gemfile
  end
end
