require 'spec_helper'

describe 's3cmd', :type => :class do
  let(:facts) { {:osfamily => 'Debian'} }
  it { should create_class('s3cmd') }
    
  context 'with default settings' do
    it { should contain_package('s3cmd').with('ensure' => 'present') }
  end
  
  context 'with setting ensure to absent' do
    let(:params) { { :ensure  => 'absent',} }
    it { should contain_package('s3cmd').with('ensure' => 'absent')}
  end
    
  context 'with invalid ensure => installed' do
    let(:params) { { :ensure => 'installed'} }
    it 'should fail' do
      is_expected.to compile.and_raise_error(/ensure must be either present or absent/)
    end
  end
  
  ['5', '6'].each do |os_major_release|
    context 'with osfamily: RedHat major release #{os_major_release}' do
      let(:facts) { {:osfamily => 'RedHat', :operatingsystemmajrelease => os_major_release} }
      it { should contain_yumrepo('s3tools').with(
        'baseurl'  => "http://s3tools.org/repo/RHEL_#{os_major_release}/",
        'gpgkey'   => "http://s3tools.org/repo/RHEL_#{os_major_release}/repodata/repomd.xml.key",
        'gpgcheck' => '1',
        'enabled'  => '1'
      ) }
      end
   end

   context 'with $::operatingsystem Amazon' do
     let(:facts) { {:osfamily => 'Linux', :operatingsystem => 'Amazon'} }
     it { should contain_yumrepo('s3tools').with(
       'baseurl'  => "http://s3tools.org/repo/RHEL_6/",
       'gpgkey'   => "http://s3tools.org/repo/RHEL_6/repodata/repomd.xml.key",
       'gpgcheck' => '1',
       'enabled'  => '1'
     ) }
   end

  context 'with unsupported $::osfamily = foo' do
    let(:facts) { {:osfamily => 'foo'} }

    it 'should fail' do
      is_expected.to compile.and_raise_error(/Osfamily foo is not supported/)
    end
  end

  context 'with unsupported operatingsystem in Linux os family' do
    let(:facts) { {:osfamily => 'Linux', :operatingsystem => 'foo'} }

    it 'should fail' do
      is_expected.to compile.and_raise_error(/Osfamily Linux with operating system foo is not supported/)
    end
  end 

end