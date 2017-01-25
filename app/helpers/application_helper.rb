module ApplicationHelper
  def paginate(objects, options = {})
    super objects, options.reverse_merge!(theme: 'twitter-bootstrap-3')
  end
end
