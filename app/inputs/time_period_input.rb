class TimePeriodInput < SimpleForm::Inputs::Base
  def input
    @builder.text_field("#{attribute_name}_number") + " &nbsp; ".html_safe +
    @builder.select("#{attribute_name}_unit",
      I18n.translate('time_period.days')   => 'day', 
      I18n.translate('time_period.weeks')  => 'week', 
      I18n.translate('time_period.months') => 'month', 
      I18n.translate('time_period.years')  => 'year'
    )
  end
end