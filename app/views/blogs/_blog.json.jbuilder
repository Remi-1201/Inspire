json.extract! blog, :id, :detail, :created_at, :updated_at
json.url blog_url(blog, format: :json)
