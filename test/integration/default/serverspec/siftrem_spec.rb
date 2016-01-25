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

describe file('/home/vagrant/Desktop/REMnux Tools Sheet') do
  it { should be_symlink }
end

describe file('/home/vagrant/Desktop/sift-cheatsheet.pdf') do
  it { should be_symlink }
end

