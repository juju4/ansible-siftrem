require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('snort') do
  it { should be_enabled }
  it { should be_running }
end

describe service('argus') do
#  it { should be_enabled }
  it { should be_running }
end

describe service('samba') do
#  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening }
end

describe port(445) do
  it { should be_listening }
end

describe file('/usr/share/remnux') do
  it { should be_directory }
end

describe file('/home/sansforensics/Desktop/REMnux Docs') do
  it { should be_symlink }
end

describe file('/home/sansforensics/Desktop/sift-cheatsheet.pdf') do
  it { should be_symlink }
end

describe command('xvfb-run --server-args="-screen 0, 1024x768x24" cutycapt --url="http://www.google.com" --out="/tmp/google.png"') do
  its(:exit_status) { should eq 0 }
end

describe command('/usr/local/bin/rip.pl -h') do
  its(:stdout) { should match /Parse Windows Registry files/ }
  its(:stderr) { should match /^$/ }
  its(:exit_status) { should eq 0 }
end

