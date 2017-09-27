#
# Cookbook Name:: webapp
# Recipe:: install::java
#
# Copyright 2017, Samsung Electronics Vietnam Co., Ltd.
#
# All rights reserved - Do Not Redistribute
#

directory "/usr/local/java" do
  owner "root"
  group "root"
  action [:delete]
  mode "0755"
  recursive true
end

cookbook_file "/usr/local/jdk-8u121-linux-x64.tar.gz" do
  source "jdk-8u121-linux-x64.tar.gz"
  owner "root"
  group "root"
  mode "0755"
end

bash "Untar java" do
  user "root"
  group "root"
  cwd "/usr/local/"
  code <<-EOF
    tar -zxvf jdk-8u121-linux-x64.tar.gz
    EOF
end

link "/usr/local/java" do
 owner "root"
 group "root"
 to "/usr/local/jdk1.8.0_121"
 link_type :symbolic
end

bash "Update JAVA_HOME & PATH" do
  user "root"
  group "root"
  cwd "/etc/profile.d"
  code <<-EOF
    touch install.sh
    grep -vE "(JAVA_HOME|PATH)" install.sh >> tmp
    echo "export JAVA_HOME=/usr/local/java" >> tmp
    echo "export PATH=$PATH:/usr/local/java/bin" >> tmp
    rm install.sh
    mv tmp install.sh
    chmod 0755 install.sh
    /etc/profile.d/install.sh
    EOF
end

file "/usr/local/jdk-8u121-linux-x64.tar.gz" do
 owner "root"
 group "root"
 action [:delete]
end

#/etc/profile.d/install.sh
#    grep -vE "(JAVA_HOME|PATH)" /etc/environment > /etc/env1
#    echo JAVA_HOME=/usr/local/java >> /etc/env1
#    echo $(grep PATH /etc/environment -m 1 | sed 's/\"//g'):/usr/local/java/bin >> /etc/env1
#    rm -rf /etc/environment
#    mv /etc/env1 /etc/environment
#    source /etc/environment
#    EOF
#end