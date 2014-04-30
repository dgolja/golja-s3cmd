require 'spec_helper'

describe 's3cmd::config', :type => :define do
  let(:title) { 'foo' }
    
  let(:default) { { :aws_access_key => 'ASmasdADS', :aws_secret_key => 'mADDFSDS' } }
  
  context 'with default values and non root user' do
    let(:params) { default }
    it { should contain_file('/home/foo/.s3cfg') }
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*gpg_passphrase =/) }
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*gpg_command = \/usr\/bin\/gpg/) }
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*bucket_location = US/) }
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*use_https = True/) }
  end
  
  context 'with aws_access_key => ASmasdADS and aws_secret_key => mADDFSDS' do
    let(:params) { { :aws_access_key => 'ASmasdADS', :aws_secret_key => 'mADDFSDS' } }
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*access_key = ASmasdADS/).with_content(/^\s*secret_key = mADDFSDS/) }
  end
  
  context 'with default values and root user' do
    let(:params) { default.merge({ :user => 'root' })}
    it { should contain_file('/root/.s3cfg') }
    it { should contain_file('/root/.s3cfg').with_content(/^\s*gpg_passphrase =/) }
    it { should contain_file('/root/.s3cfg').with_content(/^\s*gpg_command = \/usr\/bin\/gpg/) }
  end
  
  context 'with home_dir => /opt/home/foo' do
    let(:params) { default.merge({ :home_dir => '/opt/home/foo' })}
    it { should contain_file('/opt/home/foo/.s3cfg') }   
  end
  
  context 'with use_https => true' do
    let(:params) { default.merge({ :use_https => true })}   
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*use_https = True/) }
  end
 
  context 'with use_https => false' do
    let(:params) { default.merge({ :use_https => false })}
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*use_https = False/) }
  end
  
  context 'with bucket_location => EU' do
    let(:params) { default.merge({ :bucket_location => 'EU' })}
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*bucket_location = EU/) }
  end

  context 'with encryption_passphrase => blabla' do
    let(:params) { default.merge({ :encryption_passphrase => 'blabla' })}
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*gpg_passphrase = blabla/) }
  end

  context 'with proxy_host => http://localhost' do
    let(:params) { default.merge({ :proxy_host => 'localhost' })}
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*proxy_host = localhost/) }
  end
  context 'with proxy_port => 8080' do
    let(:params) { default.merge({ :proxy_port => '8080' })}
    it { should contain_file('/home/foo/.s3cfg').with_content(/^\s*proxy_port = 8080/) }
  end

end