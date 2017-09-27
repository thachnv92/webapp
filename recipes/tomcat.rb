#
# Cookbook Name:: webapp
# Recipe:: install::tomcat
#
# Copyright 2017, Samsung Electronics Vietnam Co., Ltd.
#
# All rights reserved - Do Not Redistribute
#

directory "/ggservice/tomcat8" do
  owner "gguser"
  group "gguser"
  action [:delete]
  mode "0755"
  recursive true
end

cookbook_file "/ggservice/apache-tomcat-8.5.14.tar.gz" do
  source "apache-tomcat-8.5.14.tar.gz"
  owner "gguser"
  group "gguser"
  mode "0755"
end

bash "Untar apache-tomcat-8.5.14.tar.gz" do
  user "gguser"
  group "gguser"
  cwd "/ggservice"
  code <<-EOF
    tar -zxf apache-tomcat-8.5.14.tar.gz
    EOF
end

link "/ggservice/tomcat8" do
 owner "gguser"
 group "gguser"
 to "/ggservice/apache-tomcat-8.5.14"
 link_type :symbolic
end

bash "Update CATALINA_HOME & PATH" do
  user "root"
  group "root"
  cwd "/etc/profile.d"
  code <<-EOF
    touch install.sh
    grep -vE "(CATALINA_HOME|PATH)" install.sh >> tmp
    echo "export CATALINA_HOME=/ggservice/tomcat8" >> tmp
    echo "export PATH=$PATH:/ggservice/tomcat8/bin" >> tmp
    rm install.sh
    mv tmp install.sh
    chmod 0755 install.sh
    /etc/profile.d/install.sh
    EOF
end

file "/ggservice/apache-tomcat-8.5.14.tar.gz" do
 owner "gguser"
 group "gguser"
 action [:delete]
end