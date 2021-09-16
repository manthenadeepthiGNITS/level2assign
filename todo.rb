require "date"

class Todo
  def initialize(work,due_date,status)
    @work=work
    @due_date=due_date
    @status=status
  end
  def overdue?
    if(@due_date<Date.today)
      #puts "in overdue? true"
      return true
    else
     # puts "in overdue false"
      return false
    end
  end
  def due_today?
    if(@due_date==Date.today)
      #puts "in overdue? true"
      return true
    else
     # puts "in overdue false"
      return false
    end
  end
  def due_later?
    if(@due_date>Date.today)
      #puts "in overdue? true"
      return true
    else
     # puts "in overdue false"
      return false
    end
  end

  def to_displayable_string
    if @due_date==Date.today
      track_str="[  ]"+@work.to_s
    else
      track_str="[  ]"+@work.to_s+"\t"+@due_date.to_s
    end
    #puts track_str
    return track_str
    #puts "in todo display"

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
    #puts "in overdue"
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end
  def due_today
    #puts "in overdue"
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end
  def due_later
    #puts "in overdue"
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end


  def to_displayable_list
    #puts "in todos display"
    displaylist=[]
    @todos.each do |todo|
        displaylist.push(todo.to_displayable_string)
    end
      return displaylist
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
