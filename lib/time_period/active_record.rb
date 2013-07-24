# encoding: utf-8

# Time periods
#
# monkey patch ActiveRecord::Base
#
# (c) 2012 Peter Horn, metaminded UG

class ActiveRecord::Base
  def self.time_period(name, oopts)
    opts = {validate: true, default: nil}.merge oopts

    define_method "#{name}_number" do
      if read_attribute(name)
        return read_attribute(name).split(" ").first.to_i
      else
        return 0
      end
    end

    define_method "#{name}_unit" do
      if read_attribute(name)
        return read_attribute(name).split(" ").last
      else
        return 'month'
      end
    end

    define_method "#{name}_value" do
      n = 0;
      p = ''
      if(read_attribute(name))
        n, p = read_attribute(name).split(" ")
      else
        n = 0;
        p = 'day';
      end
      case p
      when 'week'  then n.to_i.week
      when 'month' then n.to_i.month
      when 'day'   then n.to_i.day
      when 'year'  then n.to_i.year
      else raise "wrong format"
      end
    end

    define_method "#{name}_number=" do |number|
      if(read_attribute(name))
        n,p = read_attribute(name).split(" ")
      end
      p ||= 'day'
      write_attribute(name, "#{number.to_i} #{p}")
      number
    end

    define_method "#{name}_unit=" do |unit|
      if(read_attribute(name))
        n,p = read_attribute(name).split(" ")
      end
      n ||= 0
      raise "unsupported unit '#{unit}'" unless %w{day week month year}.member?(unit.to_s)
      write_attribute(name, "#{n.to_i} #{unit}")
      unit
    end

    define_method "#{name}=" do |n_u|
      n_u = '0 week' unless n_u
      number,unit = if n_u.is_a?(String)
        n_u.split(" ")
      elsif n_u.is_a?(ActiveSupport::Duration)
        u,n = n_u.parts.flatten
        [n.to_i, u.to_s.singularize]
      else raise "Can't assign '#{n_u}' to '#{name}'."
      end
      raise "unsupported unit '#{unit}'" unless %w{day week month year}.member?(unit.to_s)
      write_attribute(name, "#{number.to_i} #{unit}")
      n_u
    end

    validates_format_of(name, :with => /\A\d+ ((day)|(week)|(month)|(year))\Z/) if opts[:validate]

    before_validation do
      self.send("#{name}=", opts[:default]) unless read_attribute(name).present?
    end if opts[:default]

  end
end