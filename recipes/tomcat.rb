#
# Cookbook Name:: gitbucket
# Recipe:: tomcat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

tomcat_user = "#{node['tomcat']['user']}"
tomcat_group = "#{node['tomcat']['group']}"

cur_dir = "#{node['tomcat']['webapp_dir']}"
repo_dir = "#{node['gitbucket']['home']}"

war_file = cur_dir + "/gitbucket.war"

log "tomcat_user=" + tomcat_user + "/" + tomcat_group

directory repo_dir do
  owner tomcat_user
  group tomcat_group
  mode  00755
  action :create
end

log "war_file=" + war_file

remote_file war_file do
  source "#{node['gitbucket']['url']}"
  checksum "#{node['gitbucket']['checksum']}"
  user   tomcat_user
  group  tomcat_group
  mode   0644

  notifies :restart, "service[tomcat]",:immediately
end

