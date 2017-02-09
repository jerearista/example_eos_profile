# encoding: utf-8
# Copyright (c) 2017, Arista Networks EOS+
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of Arista Networks nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

title 'sample checks for EOS interfaces'

# only_if
# before do
#  skip if node["normal"]["foo"] == "bar"
# end

describe eos_interface('Management1') do
  it { should exist }
  its('interfaceStatus') { should eq('connected') }
  its('lineProtocolStatus') { should eq('up') }
end

describe eos_interface('Ethernet8') do
  it { should_not exist }
end

describe eos_interface('Ethernet1') do
  it { is_expected.to exist }
end

# you can also use plain tests
# describe file('/tmp') do
#  it { should be_directory }
# end

# you add controls here
# control 'tmp-1.0' do                        # A unique ID for this control
#  impact 0.7                                # The criticality, if this control fails.
#  title 'Create /tmp directory'             # A human-readable title
#  desc 'An optional description...'
#  describe file('/tmp') do                  # The actual test
#    it { should be_directory }
#  end
# end
