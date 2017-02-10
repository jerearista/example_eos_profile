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
class EosMlagMember < Inspec.resource(1)
  name 'eos_mlag_member'

  desc 'Arista EOS Multiple Link Aggregation (MLAG)'

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

  def initialize(mlag)
    @mlag = mlag
    require 'pry'
    begin
      command = 'show mlag interfaces members'
      @member = JSON.parse(inspec.command("#{command} | json").stdout)
      command = 'show port-channel summary'
      result = JSON.parse(inspec.command("#{command} | json").stdout)
      @pos = result['portChannels']
      @params = @member['interfaces'][mlag] if @member['interfaces'].key?(mlag)
      # binding.pry
    rescue StandardError
      return skip_resource "#{@mlag}: #{$ERROR_INFO}"
    end
  end

  def exists?
    #binding.pry
    @member['interfaces'].key?(@mlag)
  end

  def local_interface_status
    @pos[@params['localInterface']]['linkState']
  end

  def lacp_mode
    @pos[@params['localInterface']]['lacpMode']
  end

  def configured_members
    @pos[@params['localInterface']]['ports'].keys
  end

  def method_missing(name)
    @params[name.to_s]
  end

  def to_s
    "eos_mlag_member #{@mlag}"
  end
end
