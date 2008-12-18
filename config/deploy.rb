$:.unshift "/Users/auser/Sites/work/citrusbyte/internal/gems/pool-party/poolparty/lib"
require "poolparty/capistrano"
# require "clouds/clouds"
require "/Users/auser/Desktop/preso/demo/config/clouds/clouds"

set :application, "demo"
set :repository,  "git://github.com/auser/sample-rails-app.git"
set :keep_releases,       3
set :scm, "git"
set :branch, "master"
# set_poolparty_file "/Users/auser/Sites/work/citrusbyte/internal/ec2/cb/cb.rb"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

task :production do
  role :app, get_cloud(:app).ip
  set :user, get_cloud(:app).user
end

after "deploy", "chowner"
# after "deploy:setup", "deploy:setup_database"
after "deploy:setup_database", "deploy:migrate"
after "deploy:migrate", "deploy:restart"

namespace(:deploy) do
  task :install_rails do
    run "gem install -v=2.1.0 rails --no-rdoc --no-ri"
  end
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :migrate do
    run "cd #{current_path} && RAILS_ENV=production rake db:migrate"
  end
end

task :chowner do
  run "chown -R www-data:www-data #{release_path}"
end