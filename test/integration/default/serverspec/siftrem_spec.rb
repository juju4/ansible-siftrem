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

describe command('xvfb-run --server-args="-screen 0, 1024x768x24" cutycapt --url="http://www.google.com" --out="/tmp/google.png"') do
  its(:exit_status) { should eq 0 }
end
## FIXME! yara.SyntaxError: /opt/remnux-thug/src/Classifier/rules/urlclassifier/sweetorange.yar(19): greedy and ungreedy quantifiers can't be mixed in a regular expression
#describe command('thug.py -FZM -u win7ie90 -w 10 -T 60 -n /tmp/thuglogdir -o /tmp/thuglog.txt "http://www.google.com"') do
describe command('docker run --rm -it -v /tmp:/tmp remnux/thug ./thug.py -FZM -u win7ie90 -w 10 -T 60 -n /tmp/thuglogdir -o /tmp/thuglog.txt "http://www.google.com"') do
  its(:stdout) { should match /Thug analysis logs saved at \/tmp\/thuglogdir/ }
  its(:exit_status) { should eq 0 }
end
