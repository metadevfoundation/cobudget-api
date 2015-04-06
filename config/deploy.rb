set :application, "cobudget-api"
set :repository,  "git@github.com:enspiral/#{application}.git"
set :use_sudo,    false

set :normalize_asset_timestamps, false
default_run_options[:shell] = '/bin/bash --login'
set :scm, :git

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

task :staging do
  set :user,      "www"
  set :domain,    "cobudgetstaging.metadevfoundation.org"
  set :branch,    "master"
  set :rails_env, "staging"
  set :deploy_to, "/home/#{user}/#{application.gsub('-','/')}/"
  set :bundle_without, [:development, :test]

  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
end
task :production do
  set :user,      "cobudget"
  set :domain,    "cobudget.metadevfoundation.org"
  set :branch,    "production"
  set :rails_env, "production"
  set :deploy_to, "/home/#{user}/api/"
  set :bundle_without, [:development, :test]

  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
end

namespace :site do
  task :symlink do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  task :reset_db do
    rake_task("db:reset")
    rake_task("db:seed")
  end
end

namespace :rake do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    rake_task(ENV['task'])
  end
end

require "bundler/capistrano"
after "deploy:restart", "deploy:cleanup"
after "deploy:update_code", "site:symlink"

def rake_task(task)
  run("cd #{deploy_to}/current; /usr/bin/env bundle exec rake #{task} ENV=#{rails_env}")
end

