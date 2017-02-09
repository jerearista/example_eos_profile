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
class EosInterface < Inspec.resource(1)
  name 'eos_interface'

  desc 'Arista EOS interface stats'

  example "
    describe eos_interface('Management1') do
      it { should exist }
      its('link') { should eq('connected') }
      its('protocol') { should eq('up') }
      its('ip_address') { should eq('10.0.2.15/24') }
      its('linkStatusChanges') { should eq(52) }
      its('mode') { should eq('routed') }
      its('description') { should include('management') }
    end
  "

  def initialize(interface)
    @interface = interface
    # @intf = "show interfaces #{interface} | json"
    # command('show version | json').stdout
    require 'pry'
    begin
      # @intf = JSON.parse(inspec.command("show interfaces #{interface} | json").stdout)
      # @params = @intf['interfaces'][interface]
      @intf = JSON.parse(inspec.command('show interfaces | json').stdout)
      @params = @intf['interfaces'][interface]
      # binding.pry
    rescue StandardError
      return skip_resource "#{@intf}: #{$ERROR_INFO}"
    end
  end

  def exists?
    command = 'show interfaces status | json'
    response = JSON.parse(inspec.command(command).stdout)
    # @intf['interfaces'].has_key?(@interface)
    response['interfaceStatuses'].key?(@interface)
  end

  def link
    @params['interfaceStatus']
  end

  def protocol
    @params['lineProtocolStatus']
  end

  def ip_address
    [@params['interfaceAddress'][0]['primaryIp']['address'],
     @params['interfaceAddress'][0]['primaryIp']['maskLen'].to_s
    ].join('/')
  end

  def virtual_ip_address
    [@params['interfaceAddress'][0]['virtualIp']['address'],
     @params['interfaceAddress'][0]['virtualIp']['maskLen'].to_s
    ].join('/')
  end

  def secondary_ip
    @params['interfaceAddress'][0]['secondaryIpsOrderedList']
  end

  def linkStatusChanges
    @params['interfaceCounters']['linkStatusChanges']
  end

  def mode
    # 'bridged' or 'routed'
    @params['forwardingModel']
  end

  def method_missing(name)
    @params[name.to_s]
  end

  def to_s
    "eos_interface #{@interface}"
  end
end
