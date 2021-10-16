require 'serverspec'

# Required by serverspec
set :backend, :exec

describe port(3389) do
  it { should be_listening }
end

describe port(3350) do
  it { should be_listening }
end

describe file('/etc/xrdp/xrdp.ini') do
  it { should be_file }
end

describe file('/etc/xrdp/startwm.sh') do
  it { should be_file }
end

describe file('/etc/X11/xrdp/xorg.conf') do
  it { should be_file }
end

# multitail /var/log/auth.log /var/log/xrdp.log /var/log/xrdp-sesman.log
describe file('/var/log/xrdp.log') do
  it { should be_file }
  its(:content) { should_not match /Permission denied/ }
  its(:content) { should_not match /ERROR/ }
  its(:content) { should_not match /WARN/ }
end

describe file('/var/log/xrdp-sesman.log') do
  it { should be_file }
  its(:content) { should_not match /ERROR/ }
  its(:content) { should_not match /WARN/ }
end

describe file('/var/log/auth.log') do
  it { should be_file }
  its(:content) { should_not match /ERROR/ }
  its(:content) { should_not match /WARN/ }
  its(:content) { should_not match / pam_unix\(xrdp-sesman:auth\): Couldn\'t open \/etc\/securetty: No such file or directory/ }
  its(:content) { should_not match / xrdp-sesman.*: pam_unix\(xrdp-sesman:auth\): authentication failure; logname= uid=0 euid=0 tty=xrdp-sesman ruser= rhost=  user=sansforensics/ }
end

# describe command('/home/sansforensics/.xorgxrdp.*.log') do
#   its(:stdout) { should match // }
#   its(:stderr) { should match /^$/ }
#   its(:exit_status) { should eq 0 }
# end

# check if too many active sessions
describe command('loginctl') do
  its(:stdout) { should match /seat0/ } # lightdm or whatever applicable
  its(:stderr) { should match /^$/ }
  its(:exit_status) { should eq 0 }
end
