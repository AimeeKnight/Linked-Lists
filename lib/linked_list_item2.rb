class LinkedListItem
  include Comparable

  attr_accessor :new_item, :index, :payload
  attr_reader :payload, :next_list_item

  # called by LinkedListItem.new
  def initialize(payload)
    @payload = payload
    @next_list_item = nil
    @last = true
  end

  def next_list_item= new_item
    raise ArgumentError if self === new_item
    @next_list_item = new_item
    # set current list item to false since the new item is now the last item
    @last = false
  end

  def next_list_item 
    @next_list_item
  end

  def last?
    @last 
  end

  def <=> other
    class1 = self.payload.class
    class2 = other.payload.class

    if class1 == class2
      self.payload <=> other.payload
    else
      return 1 if class1 == Symbol or (class1 == String and class2 == Fixnum)
      return -1 if class1 == Fixnum or (class1 == String and class2 == Symbol)
    end
  end

  def === other
    self.object_id === other.object_id
  end

  def == other
    self.class == other.class
  end

end
