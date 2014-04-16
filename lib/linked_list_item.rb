class LinkedListItem
  include Comparable

  attr_accessor :payload
  attr_reader :next_list_item

  def initialize(payload)
    @payload = payload
  end

  def <=>(other_item)
    payload1 = self.payload
    payload2 = other_item.payload

    precedence = [Fixnum, String, Symbol]
    index1 = precedence.index(payload1.class)
    index2 = precedence.index(payload2.class)
    class_equality = (index1 <=> index2)

    if class_equality == 0
      #comparison results based on the actual params values since the classes are the same
      payload1 <=> payload2
    else
      # comparison results based on params class
      class_equality
    end
  end

  def ===(other_item)
    self.equal? other_item
  end

  def next_list_item=(item)
    raise ArgumentError if self === item
    @next_list_item = item
  end

  def last?
    @next_list_item.nil?
  end
end
