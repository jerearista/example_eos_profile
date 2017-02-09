# Example InSpec Profile for Arista EOS

This example shows the implementation of an InSpec
[profile](https://github.com/chef/inspec/blob/master/docs/profiles.md).

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
