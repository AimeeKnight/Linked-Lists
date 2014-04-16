require 'linked_list_item'

class LinkedList
  attr_accessor :size, :last, :val, :head

  def initialize *payloads
    @head = nil
    @tail = nil
    @last = nil
    @size = 0
    payloads.each { |item| add_item item  }
  end

  def to_s
    if @head == nil 
      val = "| |"
    elsif !@head.next_list_item
      initial_value = @head.payload
      val = "| #{initial_value} |"
    elsif @head.next_list_item
      items_left = @size -2
      initial_value = @head.payload
      next_item = @head.next_list_item
      initial_value << ", " + next_item.payload

      items_left.times do
        next_item = next_item.next_list_item
        if next_item 
          initial_value << ", " + next_item.payload
        end
        val = "| #{initial_value} |"

      end
    end
      val
  end

  def add_item payload
    item = LinkedListItem.new(payload)
    if @head == nil
      @head = item
      @tail = item
    else
      @tail.next_list_item = item
      @tail = item
      @last = item.payload
    end
    @size += 1
  end

  def get index
    raise IndexError if index < 0 

    if index == 0
      raise IndexError if @head == nil
      item = @head.payload
    elsif index == 1
      raise IndexError if @head == nil
      item = @head.next_list_item.payload
    elsif index > 1
      index -= 1
      raise IndexError if @head == nil
      next_item = @head.next_list_item
      index.times do
        raise IndexError if next_item == nil
        item = next_item.next_list_item
      end
      item = item.payload
    end
    item
  end

  def size
    if @head == nil
      @size = 0
    elsif @head.next_list_item == nil
      @size = 1
    else
      @size = 2
      current_item = @head.next_list_item
      unless !current_item.next_list_item
        current_item = current_item.next_list_item
        @size += 1
      end
      @size
    end
  end

  def [] num
    get num
  end

  def []=(index, new_payload)
    if index == 0
      item = @head
      item.payload = new_payload
    elsif index == 1
      item = @head.next_list_item
      item.payload = new_payload
    elsif index > 1
      index -= 1
      next_item = @head.next_list_item
      index.times do
        item = next_item.next_list_item
      end
      item.payload = new_payload
    end
  end

  def remove index
    current_node = @head
    if index == 0
      raise IndexError if current_node == nil 
      @head = current_node.next_list_item
    else
    index -= 1
      index.times do
        current_node = current_node.next_list_item
      end
    end
    raise IndexError if current_node == nil 
    current_node.next_list_item = current_node.next_list_item.next_list_item
  end

  def indexOf payload
    index = 1
    if @head == nil
      nil
    elsif @head.payload == payload
      return index = 0
    else
      current_item = @head.next_list_item

      while current_item
        if current_item.payload == payload
          return index
        elsif current_item.next_list_item == nil
          return nil
        else
          index += 1 
          current_item = current_item.next_list_item
        end
      end
    end
  end

  def sorted?
    return true if @head == nil
      current_node = @head
      until @size == 1 
        return false if current_node > current_node.next_list_item
        @size -= 1
        current_node = current_node.next_list_item
      end
    true
  end

end
