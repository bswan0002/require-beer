json.extract! project, :id, :user_id, :title, :desc, :vidlink, :gitlink, :created_at, :updated_at
json.url project_url(project, format: :json)
