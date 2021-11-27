require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/usr/local/bin/eicargen') do
  it { should be_symlink }
end

describe file('/usr/local/bin/js') do
  it { should be_symlink }
end

describe command('/usr/local/bin/eicargen') do
  its(:stdout) { should match /^$/ }
  its(:stderr) { should match /Usage: EICARgen write/ }
  its(:exit_status) { should eq 255 }
end

describe command('/usr/local/bin/js --help') do
  its(:stdout) { should match /^$/ }
  its(:stderr) { should match /JavaScript-C / }
  its(:exit_status) { should eq 2 }
end

describe command('/usr/local/bin/xorsearch-x64-static') do
  its(:stdout) { should match /^$/ }
  its(:stderr) { should match /Usage: XORSearch / }
  its(:exit_status) { should eq 255 }
end
