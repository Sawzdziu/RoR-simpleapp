module ApplicationHelper

  def status_widoku(boolean, options={})
    options[:true_text] ||= ''
    options[:false_text] ||= ''
    if boolean
      content_tag(:span, options[:true_text], :class => 'glyphicon glyphicon-ok')
    else
      content_tag(:span, options[:false_text], :class => 'glyphicon glyphicon-remove')
    end
  end

  def blad(objekt)
    render(:partial => 'dodatki/bledy', :locals => {:objekt => objekt})
  end

end
