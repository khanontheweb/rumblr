require 'sinatra/activerecord'
require 'sinatra'
require 'date'

enable :sessions

if ENV['RACK_ENV'] == 'development'
  #connect database to the sqlite3 file during development
  set :database, {adapter: 'sqlite3', database: 'database.sqlite3'}
else
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) #if production we using heroku database
end

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
  serialize :tags,Array
  belongs_to :author
end

get '/' do #CREATE
  if(session[:user_id].nil?) #if no user is logged in then give the option to sign up or login
    erb :home
  else
    redirect '/users/dash' #if the user is logged in, show their dashboard
  end
end

#POST STUFF HERE#
post '/posts/new' do
  user = User.find(session[:user_id]) #find the user that is making the article
  tags = params['tags'].gsub(/\s+/,"").split("#") #split up the tags into an array # is the delimiter
  time = DateTime.now
  time.strftime("%m/%d/%Y %H:%M")
  article = user.posts.create(title: params['title'], body: params['body'], tags: tags, created_at: time)
  redirect '/users/dash'
end

#USER STUFF HERE#

post '/users/delete' do #delete
  user = User.find(session[:user_id])
  user.destroy
  session[:user_id] = nil
  redirect '/'
end

get '/users/dash' do #READ
  @user = User.find(session[:user_id]) #grab the user by checking the value of user id in session hash
  erb :'/users/dash'
end

post '/users/logout' do #CREATE
  session[:user_id] = nil
  redirect '/'
end


post '/users/signup' do #CREATE
  @user = User.new(fname: params['fname'], lname: params['lname'], email: params['email'], birthday: params['birthday'], password: params['password']) #make the user
  @user.save #save user to db
  session[:user_id] = @user.id #this session belongs to this user
  redirect "/users/dash" #show the users dash
end

post '/users/login' do #CREATE
  user = User.find_by(email: params['email']) #find user by their email
  if !user.nil? #check if the user even exists, if not we should be throwing an error hear FEEDBACK
    if user.password == params['password'] #if the password matches, session belongs to user, show dash
      session[:user_id] = user.id
      redirect '/users/dash'
    end
  end
end

get '/users/:id' do #READ
  @user = User.find(params['id']) #using user id instead of session hash for url purposes
  erb :'/users/profile'
end
