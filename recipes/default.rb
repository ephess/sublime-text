#
# Cookbook Name:: sublime-text
# Recipe:: default
#
# Copyright 2013, Jordan (ephess) Hagan
#

apt_repository 'sublime-text-2' do
	uri 'http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu'
	distribution node['lsb']['codename']
	components ['main']
	keyserver 'keyserver.ubuntu.com'
	key 'EEA14886'
end

package "sublime-text" do
	action :install
end
