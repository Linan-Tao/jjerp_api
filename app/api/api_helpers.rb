module ApiHelpers

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def encode_user_token(openid:, session_key:)
    JWT.encode({ openid: openid, session_key: session_key }, ENV['SECRET_KEY_BASE'], 'HS256')
  end


  def error!(msg, *args)
    if msg.is_a?(ActiveModel::Errors)
      super({ error: msg.as_json, error_message: msg.full_messages.join(', ') }, *args)
    elsif msg.is_a?(String)
      super({ error: msg, error_message: msg }, *args)
    else
      super
    end
  end

  # 验证用户
  def authenticate!
    error!({ error: '身份验证失败' }, 401) unless current_worker
  end

  # 分页数据
  def paginate_collection(collection, params)
    collection.page(params[:_page]).per(params[:_per_page])
  end

  # 生产分页数据的JSON
  def wrap_collection(collection, with_entity, options={})
    present meta: {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
    present :data, collection, options.merge(with: with_entity)
  end

  # 用_sortable中的参数对集合排序
  def sort_collection(collection)
    params[:_sort] ? collection.order(params[:_sort].value) : collection
  end
end
