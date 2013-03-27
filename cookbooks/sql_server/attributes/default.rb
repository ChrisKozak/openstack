#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: sql_server
# Attribute:: default
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#TODO: Is this just a copy of a public sql_server cookbook?  If so, use berkshelf and wrap it with ulti-sql_server.  Move accept_eula to wrapper
#Why do these live in default?  Shouldn't they be in the server attributes?  Does the client use either of these?
default['sql_server']['accept_eula'] = true
default['sql_server']['product_key'] = nil
