#
# Cookbook Name:: sublime-text
# Recipe:: user
#
# Copyright 2013, Jordan (ephess) Hagan
#

include_recipe "sublime-text"

package "git"
package "mercurial"

node['sublime-text']['user_installs'].each do |install|
	## Resource for simulating a sublime-text restart
	execute "restart sublime for #{install['user']}" do
		command "subl --command exit"
		user install['user']
		group install['user']
		environment ({'HOME' => "/home/#{install['user']}"})
		action :nothing
	end

	## Setup and populate config directory
	directory ::File.join( '/home', install['user'], '.config/sublime-text-2' ) do
		owner install['user']
		group install['user']
		mode 00755
		action :create
		notifies :run, "execute[restart sublime for #{install['user']}]", :immediately
	end

	## Install any packages defined in the nodes configuration
	install['packages'].each do |pkg|
		sublime_text_package pkg['name'] do
			uri pkg['uri']
			vcs pkg['vcs']
			user install['user']
			group install['user']
			action :install
		end
	end

	## Add config files to users home directory
	install["user_config_files"].each do |file|
		file File.join('/home', install['user'], '.config/sublime-text-2/Packages/User/', file['filename']) do
			action :create
			owner install['user']
			group install['user']
			mode 00644

			if file['data'].respond_to? 'to_hash'
				content JSON.pretty_generate(file['data'].to_hash)
			else
				content JSON.pretty_generate(file['data'])
			end
		end
	end
end
