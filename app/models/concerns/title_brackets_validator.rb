class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    unless brackets_closed?(record.title)
      record.errors[:title] << 'has incorrectly created brackets. Check if they are matching and they are not empty'
    end
  end

  private

  def brackets_closed?(title)
    brackets_stack   = []
    brackets         = { '(' => ')', '[' => ']', '{' => '}' }

    title.each_char.with_index do |c, i|
      if brackets.key?(c)
        return false if c == brackets.key(title[i+1])
        brackets_stack << c
      elsif brackets.value?(c)
        c == brackets[brackets_stack.last] ? brackets_stack.pop : (return false)
      end
    end
    brackets_stack.empty?
  end
end
