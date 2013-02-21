#
# Cookbook Name:: sublime-text
#
# Copyright 2013, Jordan (ephess) Hagan
#

actions :install, :uninstall
default_action :install

attribute :name, :kind_of => String, :name_attribute => true 
attribute :uri, :kind_of => String
attribute :vcs, :equal_to => ['hg', 'git']
attribute :user, :kind_of => String
attribute :group, :kind_of => String
