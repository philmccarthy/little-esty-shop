module ApplicationHelper
  def enum_collection_for_select(attribute, include_blank = true)
    x = attribute.map { |r| [r[0].titleize, r[0]] }
    x.insert(0,['', '']) if include_blank == true
    x
  end

  def resource_name
    :user
  end
  
  def resource
    @resource ||= User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def resource_class
    devise_mapping.to
  end
end
