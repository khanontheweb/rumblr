require 'sinatra/activerecord'
require 'sinatra'

enable :sessions

set :database, {adapter: 'sqlite3', database: 'database.sqlite3'}

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
  store :tags
  belongs_to :author
end

get '/' do
  p 'Hello World'
end
