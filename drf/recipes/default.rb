#
# Cookbook Name:: temp
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{git git-svn sshpass}.each do |pkg|
package pkg do
	action :install
end
end

script "clone repo" do
  interpreter "bash"
  flags "-x"
  user "root"
  cwd "/home/vagrant"
  code <<-EOH
  /usr/bin/git svn clone svn+ssh://deploy@drf.prometheusdata.com/home/svn/weboniselab/#{node['svn']['reponame']}
  sed 's/deploy/#{node['svn']['username']}' /home/vagrant/#{node['svn']['reponame']}/.git/config
  EOH
end