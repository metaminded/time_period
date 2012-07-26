class TimePeriodInput < SimpleForm::Inputs::Base
  def input
    # attribute_name = attribute_name + '_number'
    # "$ #{@builder.text_field(attribute_name, input_html_options)}"+ " &nbsp; ".html_safe #+
    @builder.text_field("#{attribute_name}_number", input_html_options) + " &nbsp; ".html_safe +
    @builder.select("#{attribute_name}_unit", {
      I18n.translate('time_period.days')   => 'day', 
      I18n.translate('time_period.weeks')  => 'week', 
      I18n.translate('time_period.months') => 'month', 
      I18n.translate('time_period.years')  => 'year'}, {}, input_html_options
    )
  end
end