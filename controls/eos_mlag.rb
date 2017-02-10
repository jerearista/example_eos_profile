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
require 'rspec/collection_matchers'

title 'sample checks for the state of MLAGs'

only_if do
  command('show running-config').stdout =~ /mlag/
end

describe eos_mlag do
  it { should exist }
  #its('state') { should eq('active') }
  its('state') { should eq('inactive') }
  its('domainId') { should eq('cboe') }
  its('localInterface') { should eq('Vlan4094') }
  #its('localIntfStatus') { should eq('up') }
  its('localIntfStatus') { should eq('lowerLayerDown') }
  its('peerAddress') { should eq('10.0.0.2') }
  its('peerLink') { should eq('Port-Channel1000') }
  #its('peerLinkStatus') { should eq('up') }
  its('peerLinkStatus') { should eq('lowerLayerDown') }
  its('peer_link_members') { should have(2).entres }
end

describe eos_mlag_member('733') do
  it { should exist }
  its('localInterface') { should eq('Port-Channel733')}
  its('local_interface_status') { should eq('down') }
  its('lacp_mode') { should eq('active') }
  its('members') { should have(0).entries }
  its('configured_members') { should have(1).entries }
end
