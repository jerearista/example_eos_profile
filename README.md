# Example InSpec Profile for Arista EOS

This example shows the implementation of an InSpec
[profile](https://github.com/chef/inspec/blob/master/docs/profiles.md).

## Sample Output

```
$ bundle exec inspec exec . -t ssh://jere:icanttellyou@192.0.2.2

Profile: Example InSpec Profile for Arista EOS (eos_example)
Version: 0.1.0
Target:  ssh://jere@192.0.2.2:22


  eos_interface Ethernet8
     ✔  should not exist
  eos_mlag domain
     ✔  cboe should exist
     ✔  cboe state should eq "inactive"
     ✔  cboe domainId should eq "cboe"
     ✔  cboe localInterface should eq "Vlan4094"
     ✔  cboe localIntfStatus should eq "lowerLayerDown"
     ✔  cboe peerAddress should eq "10.0.0.2"
     ✔  cboe peerLink should eq "Port-Channel1000"
     ✔  cboe peerLinkStatus should eq "lowerLayerDown"
     ✔  cboe peer_link_members should have 2 entres
  eos_mlag_member 733
     ✔  should exist
     ✔  localInterface should eq "Port-Channel733"
     ✔  members should have 0 entres
     ✔  local_interface_status should eq "down"
     ✔  lacp_mode should eq "active"
     ✔  configured_members should have 1 entres

Test Summary: 16 successful, 0 failures, 0 skipped
```

## Usage

This profile is typically run remotely via SSH to an Arista EOS device:
```
git clone https://github.com/jerearista/example_eos_profile.git
cd example_eos_profile
bundle exec inspec exec example_eos_profile -t ssh://<username>:<password>@<switch_IP_address>
```

Or, run it directly from GitHub:
```
bundle exec inspec exec https://github.com/jerearista/example_eos_profile -t ssh://<username>:<password>@<switch_IP_address>
```

If you do not have InSpec installed system-wide then use bundler:
```
git clone https://github.com/jerearista/example_eos_profile.git
cd example_eos_profile
bundle install --path=.bundle/gems
bundle exec inspec exec . -t ssh://<username>:<password>@<switch_IP_address>
```

## License and Author

* Author:: Jere Julian <jere@arista.com>

BSD 3-clause license. See the [license](LICENSE) file for details.
