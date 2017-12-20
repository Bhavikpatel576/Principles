
module ShoutHelper
  def shout_form_for(type)
    form_for Shout.new do |form|
      form.hidden_field(:content_type, value: type) + 
      form.fields_for(:content) { |content_form| yield(content_form) } + 
      form.submit("Shout!") 
    end
  end

  def like_button(shout)
    if current_user.liked?(shout)
      link_to "Unlike", unlike_shout_path(shout), method: :delete
    else
      link_to "Like", like_shout_path(shout), method: :post
    end
  end

  def auto_link(text)
    text.gsub(/@\w+/) { |mention| link_to mention, user_path(mention[1..-1]) }.html_safe
  end
end
