# Copyright 2015 Nordstrom, Inc.
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
include_recipe 'chef_vault_try_notify'

chef_vault_try_notify 'my_secrets' do
  vault_items %w(foo/bar baz/wibble)
  test_and_remember true
end

chef_vault_try_notify 'my_other_secrets' do
  vault_items %w(foo/other_bar baz/other_wibble)
  test_and_remember true
end

file '/tmp/secrets_ok' do
  only_if { vault_available?('my_secrets') }
end

file '/tmp/secrets_failure' do
  only_if { vault_available?('my_other_secrets') }
end
