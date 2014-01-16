# encoding: utf-8

# Time periods
#
# monkey patch ActiveRecord::Base
#
# (c) 2012 Peter Horn, metaminded UG

require "time_period/version"
require "time_period/duration"
require "time_period/active_record"

module TimePeriod
  class Engine < Rails::Engine
    # Woohoo
  end
end