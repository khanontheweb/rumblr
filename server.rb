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

get '/' do #CREATE
  erb :home
end



get '/users/:id' do #READ
  @user = User.find(params['id'])
  erb :'/users/profile'
end

post '/users/signup' do #CREATE
  @user = User.new(fname: params['fname'], lname: params['lname'], email: params['email'], birthday: params['birthday'], password: params['password'])
  @user.save
  session[:user_id] = @user.id
  redirect "/users/#{@user.id}"
end
