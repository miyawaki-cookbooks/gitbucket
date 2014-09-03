#
# Cookbook Name:: gitbucket
# Recipe::set_path_datadir 
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cur_dir = "#{node['tomcat']['webapp_dir']}"
repo_dir = "#{node['gitbucket']['home']}"

file_name = cur_dir + "/gitbucket/WEB-INF/web.xml"
log "web.xml=" + file_name

ruby_block "Set PATH_TO_DATADIR" do
  block do
    retries 3
    retry_delay 5

    config_file = Chef::Util::FileEdit.new(file_name)
    config_file.search_file_replace_line(/Optional configurations/,
        "  <context-param>\n" +
        "    <param-name>gitbucket.home</param-name>\n" +
        "    <param-value>" + repo_dir + "</param-value>\n" +
        "  </context-param>" )
    config_file.write_file

  end
  notifies :restart, "service[tomcat]"
end

