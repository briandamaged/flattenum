
module Flattenum


  def self.should_flatten?(thing)
    thing.is_a? Array or thing.is_a? Enumerator
  end


  def flattenum(thing)
    return enum_for(__callee__, thing) unless block_given?

    if ::Flattenum.should_flatten?(thing)
      thing.each do |potential_object|
        flattenum(potential_object).each do |object|
          yield object
        end
      end

    else
      yield thing
    end
  end
  module_function :flattenum


  class << self
    alias_method :this, :flattenum
  end

end
