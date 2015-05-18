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

node['svn']['repositories'].each do |r|
execute r do
	command "echo #{r} >> /tmp/txt"
end

script "clone repo #{r}" do
  interpreter "bash"
  flags "-x"
  user "root"
  cwd "/vagrant"
  code <<-EOH
  /usr/bin/git svn clone --branch trunk svn+ssh://deploy@drf.prometheusdata.com/home/svn/weboniselab/#{r}
  /bin/sed -i 's/deploy/#{node['svn']['username']}/g' #{r}/.git/config
  EOH
end
end
