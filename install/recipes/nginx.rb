#
# Cookbook Name:: webapp
# Recipe:: install::nginx
#
# Copyright 2017, Samsung Electronics Vietnam Co., Ltd.
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/ggservice/zlib-1.2.11.tar.gz" do
  source "zlib-1.2.11.tar.gz"
  owner "gguser"
  group "gguser"
  mode "0755"
end

bash "Untar zlib-1.2.11.tar.gz file" do
  user "gguser"
  group "gguser"
  cwd "/ggservice/"
  code <<-EOF
    tar -zxf zlib-1.2.11.tar.gz
    EOF
end

bash "Install zlib" do
 user "gguser"
 group "gguser"
 cwd "/ggservice/zlib-1.2.11"
 code <<-EOF
  make
  sudo make install
  EOF
end

cookbook_file "/ggservice/openssl-1.0.2f.tar.gz" do
  source "openssl-1.0.2f.tar.gz"
  owner "gguser"
  group "gguser"
  mode "0755"
end

bash "Untar openssl-1.0.2f.tar.gz file" do
  user "gguser"
  group "gguser"
  cwd "/ggservice/"
  code <<-EOF
    tar -zxf openssl-1.0.2f.tar.gz
    EOF
end

bash "Install openssl" do
 user "gguser"
 group "gguser"
 cwd "/ggservice/openssl-1.0.2f"
 code <<-EOF
  make
  sudo make install
  EOF
end

cookbook_file "/ggservice/nginx-1.12.0.tar.gz" do
  source "nginx-1.12.0.tar.gz"
  owner "gguser"
  group "gguser"
  mode "0755"
end

bash "Untar nginx-1.12.0.tar.gz file" do
  user "gguser"
  group "gguser"
  cwd "/ggservice/"
  code <<-EOF
    tar -zxf nginx-1.12.0.tar.gz
    EOF
end

bash "Install nginx" do
 user "gguser"
 group "gguser"
 cwd "/ggservice/nginx-1.12.0"
 code <<-EOF
  ./configure
  EOF
end

link "/ggservice/nginx" do
 owner "gguser"
 group "gguser"
 to "/ggservice/nginx-1.12.0"
 link_type :symbolic
end