#
# Cookbook Name:: gitbucket
# Recipe:: java
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cur_dir = "#{node['gitbucket']['install_dir']}"
repo_dir = "#{node['gitbucket']['home']}"

war_file = "#{cur_dir}/gitbucket.war"
#ver_file = "gitbucket_#{version}"

directory cur_dir do
  owner "root"
  group "root"
  mode  00644
  action :create
end

directory repo_dir do
  owner "root"
  group "root"
  mode  00644
  action :create
end

remote_file war_file do
  source "#{node['gitbucket']['url']}"
  user   "root"
  group  "root"
  mode   0644
end

template "/etc/init.d/gitbucket" do
  source "gitbucket.erb"
  group "root"
  owner "root"
  mode "0755"
end

service "gitbucket" do
#  supports :start => true, :restart => true
  action [ :enable, :start ]
end
