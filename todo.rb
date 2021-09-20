require "date"

class Todo
  def initialize(work,due_date,status)
    @work=work
    @due_date=due_date
    @status=status
  end
  def overdue?
    Date.today > @due_date
  end
  def due_today?
    @due_date==Date.today
  end
  def due_later?
    @due_date>Date.today
  end

  def to_displayable_string
    if @due_date.instance_of?(Date)
      if @status==true
        track_str="[*]"
      elsif @status==false
        track_str="[ ]"
      else
        track_str="invalid status"
      end
      if @due_date==Date.today
        track_str=track_str+@work.to_s
      else
        track_str=track_str+@work.to_s+"\t"+@due_date.to_s
      end
    end
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end
  def add(todo)
    @todos.push(todo)
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end


  def to_displayable_list
    displaylist=@todos.map{|todo|
       todo.to_displayable_string}
    end
  end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
