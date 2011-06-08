# -*- coding: utf-8 -*-
# FormtasticDatepickerInputs
#To get this solution working in Rails 3, replace:
#
#format = options[:format] || ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default] || ‘%d %b %Y’
#
#with:
#
#format = options[:format] || Date::DATE_FORMATS[:default] || ‘%d %b %Y’
module Formtastic
  if defined?(ActiveSupport::CoreExtensions)
	DATE_FORMATS = ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS
  else
	DATE_FORMATS = Date::DATE_FORMATS
  end
 
  module DatePicker
    protected

    def date_picker_input(method, options = {})
      format = options[:format] || DATE_FORMATS[:default] || '%d %b %Y'
      
      opts = date_picker_options(format, options, object.send(method))
      string_input(method, opts)
    end

    # Generate html input options for the datepicker_input
    #
    def date_picker_options(format, opts, value = nil)
      
      input_opts = {:class => 'ui-date-picker',:value => value.try(:strftime, format)}
      input_opts[:class] = (input_opts[:class].concat(' ')).concat(opts.delete(:class)) if opts[:class]
      input_opts = input_opts.merge(opts.delete(:input_html)) if opts[:input_html]
      
      opts.merge({:input_html => input_opts})
    end
  end
  
  module DateTimePicker
    protected

    def datetime_picker_input(method, options = {})
      format = options[:format] || DATE_FORMATS[:default] || '%d %b %Y %H:%M'
      string_input(method, datetime_picker_options(format, options, object.send(method)))
    end

    # Generate html input options for the datepicker_input
    #
    def datetime_picker_options(format, opts, value = nil)
      input_opts = {:class => 'ui-datetime-picker', :value => value.try(:strftime, format)}
      input_opts[:class] = (input_opts[:class].concat(' ')).concat(opts.delete(:class)) if opts[:class]
      input_opts = input_opts.merge(opts.delete(:input_html)) if opts[:input_html]
      
      {:wrapper_html => {:class => 'datetime'}, 
        :input_html => input_opts }.merge(opts)
    end
  end
end

Formtastic::SemanticFormBuilder.send(:include, Formtastic::DatePicker)
Formtastic::SemanticFormBuilder.send(:include, Formtastic::DateTimePicker)
