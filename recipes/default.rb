#
# Cookbook Name:: gitbucket
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ins_type = "#{node['gitbucket']['type']}"

log "ins_type=" + ins_type 

case ins_type
when "java"
  include_recipe "gitbucket::java"
when "tomcat"
  include_recipe "gitbucket::tomcat"
  include_recipe "gitbucket::set_path_datadir"
end
