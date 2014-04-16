class LinkedList
  attr_reader :size

  def initialize *payloads
    @size = 0
    payloads.each { |item| add_item item  }
  end

  def add_item(payload)
    lli = LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = lli
    else
      item = @first_item
      until item.last?
        item = item.next_list_item
      end
      item.next_list_item = lli
    end
    @size += 1
  end

  def get(i)
    raise IndexError if i < 0 or i >= size
    item = @first_item
    i.times do
      item = item.next_list_item
    end
    item.payload
  end

  def last
    if size == 0
      nil
    else
      get(size - 1)
    end
  end

  def to_s
    result = "|"
    item = @first_item
    until item.nil?
      result << " " + item.payload.to_s
      result << "," unless item.last?
      item = item.next_list_item
    end
    result + " |"
  end

  #def [] num
   # get num
  #end
  
  #if you see bracket, call get
  alias [] get

  def []=(index, new_payload)
    current_item = @first_item
    if index == 0
      current_item.payload = new_payload
    else
      index.times do
        current_item = current_item.next_list_item
      end
      current_item.payload = new_payload
    end
  end

  def size
    @size = 0
    return @size if @first_item.nil?
    current_item = @first_item
    until current_item.nil?
      @size += 1
      current_item = current_item.next_list_item
    end
    @size
  end

  def remove index
    current_item = @first_item
    if index == 0
      raise IndexError if current_item.nil? 
      @first_item = current_item.next_list_item
    else
    index -= 1
      index.times do
        current_item = current_item.next_list_item
      end
    end
    raise IndexError if current_item.nil? 
    current_item.next_list_item = current_item.next_list_item.next_list_item
  end

  def indexOf payload
    index = 0
    current_item = @first_item
    return nil if @first_item.nil?
    while current_item
      return index if current_item.payload == payload
      index += 1 
      current_item = current_item.next_list_item
    end
  end

  def sorted?
    current_item = @first_item
    return true if current_item.nil?
      until current_item.last? 
        return false if current_item > current_item.next_list_item
        current_item = current_item.next_list_item
      end
    true
  end

  def sort
    return "| |" if @first_item.nil?

    item = @first_item
    until sorted?
      if (item <=> item.next_list_item) == 1
        item.payload, item.next_list_item.payload = item.next_list_item.payload, item.payload
        sort
      else
        item = item.next_list_item
      end
    end
    self.to_s
  end

  def swap_with_next index
    swap_left = get(index)
    swap_right = get(index + 1)
    
    self[index], self[index + 1] = swap_right, swap_left
  end
  
end



