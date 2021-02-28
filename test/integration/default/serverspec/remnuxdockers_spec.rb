require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('docker-ce') do
  it { should be_installed }
  its('version') { should >= '1.12' }
end

## https://remnux.org/docs/containers/malware-analysis/
describe command('docker run --rm -it -v /tmp:/tmp remnux/thug thug -FZM -u win7ie90 -w 10 -T 60 -n /tmp/thuglogdir -o /tmp/thuglog.txt "http://www.google.com"') do
  #its(:stdout) { should match /Thug analysis logs saved at \/tmp\/thuglogdir/ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
describe command('docker run --rm -it remnux/radare2 r2 -v') do
	its(:stdout) { should match /radare2 5.1.1 1 @ linux-x86-64 git./ }
  its(:stderr) { should_not match /operation not permitted/ }
  its(:exit_status) { should eq 0 }
end
## this one need longer initialization
#docker run --rm -it -p 443:443 -v ~/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data remnux/metasploit
#describe command('docker run --rm -it remnux/metasploit ls msfconsole') do
#  its(:stdout) { should match /msfconsole/ }
#  its(:stderr) { should_not match /operation not permitted/ }
#  its(:exit_status) { should eq 0 }
#end
