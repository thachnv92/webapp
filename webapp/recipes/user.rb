#
# Cookbook Name:: webapp
# Recipe:: install::user
#
# Copyright 2017, Samsung Electronics Vietnam Co., Ltd.
#
# All rights reserved - Do Not Redistribute
#

group "gguser" do
  group_name "gguser"
  action :create
  system true
end

user "gguser" do
  username "gguser"
  action :create
  group "gguser"
  home "/home/gguser"
  shell "/bin/bash"
  non_unique false
end
