require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('docker-engine') do
  it { should be_installed }
  its('version') { should >= '1.12' }
end

## https://remnux.org/docs/containers/malware-analysis/
describe command('docker run --rm -it -v /tmp:/tmp remnux/thug thug -FZM -u win7ie90 -w 10 -T 60 -n /tmp/thuglogdir -o /tmp/thuglog.txt "http://www.google.com"') do
  its(:stdout) { should match /Thug analysis logs saved at \/tmp\/thuglogdir/ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
describe command('docker run --rm -it remnux/volatility ./vol.py -h') do
  its(:stdout) { should match /Volatility Foundation Volatility Framework 2.5/ }
  its(:stdout) { should match /Usage: Volatility - A memory forensics analysis platform./ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
describe command('docker run --rm -it remnux/radare2 r2 -v') do
  its(:stdout) { should match /radare2 0.10.3-git 11182 @ linux-x86-64 git.0.10.2-239-ge804d5d/ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
## this one need longer initialization
#docker run --rm -it -p 443:443 -v ~/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data remnux/metasploit
describe command('docker run --rm -it remnux/metasploit ls msfconsole') do
  its(:stdout) { should match /msfconsole/ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
