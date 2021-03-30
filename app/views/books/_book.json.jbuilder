json.extract! book, :id, :title, :user_id, :state, :created_at, :updated_at
json.url book_url(book, format: :json)
