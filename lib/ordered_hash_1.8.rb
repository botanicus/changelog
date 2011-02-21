# This is a hack from http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/20551
# But seriously folks, just for fuck sake upgrade your damn Ruby finally :/
# I shall drop 1.8 support at some point, not very soon, but it's a matter of months,
# not years, OK?
class OrderedHash < Hash
  alias_method :store, :[]=
  alias_method :each_pair, :each

  attr_reader :keys
  def initialize
    @keys = []
  end

  def []=(key, val)
    @keys << key
    super
  end

  def delete(key)
    @keys.delete(key)
    super
  end

  def each
    @keys.each { |k| yield k, self[k] }
  end

  def each_key
    @keys.each { |k| yield k }
  end

  def each_value
    @keys.each { |k| yield self[k] }
  end

  def merge(hash)
    @keys.push(*hash.keys)
    super(hash)
  end

  def select(&block)
    self.inject(self.class.new) do |buffer, pair|
      if block.call(*pair)
        buffer.merge(pair[0] => pair[1])
      end
      buffer
    end
  end
end
