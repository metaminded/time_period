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
      read_attribute(name).split(" ").first.to_i
    end

    define_method "#{name}_unit" do
      read_attribute(name).split(" ").last
    end

    define_method "#{name}_value" do
      n, p = read_attribute(name).split(" ")
      case p
      when 'week'  then n.to_i.week
      when 'month' then n.to_i.month
      when 'day'   then n.to_i.day
      when 'year'  then n.to_i.year
      else raise "wrong format"
      end
    end

    define_method "#{name}_number=" do |number|
      n,p = read_attribute(name).split(" ")
      p ||= 'day'
      write_attribute(name, "#{number.to_i} #{p}")
      number
    end

    define_method "#{name}_unit=" do |unit|
      n,p = read_attribute(name).split(" ")
      raise "unsupported unit '#{unit}'" unless %w{day week month year}.member?(unit.to_s)
      write_attribute(name, "#{n.to_i} #{unit}")
      unit
    end

    define_method "#{name}=" do |n_u|
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

    validates_format_of(name, :with => /^\d+ ((day)|(week)|(month)|(year))$/) if opts[:validate]

    before_validation do
      self.send("#{name}=", opts[:default]) unless read_attribute(name).present?
    end if opts[:default]

  end
end