#
# Cookbook Name:: gitbucket
# Attributes:: default
# 
# Copyright 2010, Opscode, Inc.
# Copyright 2014, YOUR COMPANY.

default["gitbucket"]["type"] = "java"

default["gitbucket"]["url"] = "https://github.com/takezoe/gitbucket/releases/download/2.3/gitbucket.war"
default["gitbucket"]["checksum"] = "5457b9a35ae33c339050114f9b7f19fe60b052a4181a29abccb952abbdb65ff3"

default["gitbucket"]["home"] = "/var/lib/gitbucket"
default["gitbucket"]["ins_dir"] = "/var/lib/gitbucket"
default["gitbucket"]["port"] = "8765"

