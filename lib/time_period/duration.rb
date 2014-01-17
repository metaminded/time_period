class TimePeriod::Duration

  attr_reader :number, :unit

  def initialize(a1, a2=nil)
    if a2.blank?
      @number, @unit = a1.split " "
    else
      @number = a1
      @unit = a2
    end
    @number = @number.to_i
    @unit = @unit.to_s.downcase.strip
    raise "illegal unit `#{@unit}'" unless %w{day week month year}.member?(@unit.to_s)
    @str = "#{@number} #{@unit}"
  end

  def to_s
    @str
  end
  alias_method :to_str, :to_s
  alias_method :inspect, :to_s

  def duration
    case @unit
    when 'week'  then @number.week
    when 'month' then @number.month
    when 'day'   then @number.day
    when 'year'  then @number.year
    else raise "wrong format"
    end
  end

  def to_i
    duration.to_i
  end
  alias_method :to_int, :to_i

  def <=>(other)
    self.to_i <=> other.to_i
  end

  def +(other)
    raise "can't add #{other.unit} to #{unit}" unless other.unit == unit
    TimePeriod::Duration.new(other.number + number, unit)
  end

  def <(other)
    (self <=> other)  < 0
  end

  def ==(other)
    (self <=> other)  == 0
  end

  def >(other)
    (self <=> other)  > 0
  end

  def <=(other)
    (self <=> other)  <= 0
  end

  def >=(other)
    (self <=> other)  >= 0
  end

  def !=(other)
    (self <=> other)  == 0
  end
end
