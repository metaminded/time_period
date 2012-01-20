class TimePeriodInput < SimpleForm::Inputs::Base
  def input
    @builder.text_field("#{attribute_name}_number") + " &nbsp; ".html_safe +
    @builder.select("#{attribute_name}_unit",
      {"Tage" => 'day', "Wochen" => 'week', "Monate" => 'month', "Jahre" => 'year'})
  end
end