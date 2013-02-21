#
# Cookbook Name:: sublime-text
#
# Copyright 2013, Jordan (ephess) Hagan
#

action :install do
	Chef::Log.debug( "Checking if package #{new_resource.name} already exists at #{package}.")
	unless ::File.exists? package
		if new_resource.vcs == "git"
			execute "checkout package" do
				command "git clone #{new_resource.uri} '#{package}'"
				notifies :run, "execute[restart sublime for #{new_resource.user}]"
			end
		elsif new_resource.vcs == "hg"
			execute "checkout package" do
				command "hg clone #{new_resource.uri} '#{package}'"
				notifies :run, "execute[restart sublime for #{new_resource.user}]"
			end
		end
		execute "chown -R #{new_resource.user}.#{new_resource.group} '#{package}'"
		new_resource.updated_by_last_action true
	end
end

action :uninstall do
	Chef::Log.debug( "Checking to see if we need to uninstall #{new_resource.name} at #{package}.")
	if ::File.exists? package
		file package do
			action :delete
			notifies :run, "execute[restart sublime for #{new_resource.user}]", :delayed
		end
		new_resource.updated_by_last_action true
	end
end

def package
	::File.join( '/home/', new_resource.user, '.config/sublime-text-2/Packages', "#{new_resource.name}" )
end
