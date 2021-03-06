include_recipe 'core::download_vendor_artifacts_prereqs'

artifact = node[:platform] == 'ubuntu' ? 'jdk_ubuntu' : 'jdk_windows'
download_directory = '/installs'
install_directory = '/jdk'

template "#{node[:ruby_scripts_dir]}/download_jdk.rb" do
  local true
  source "#{node[:ruby_scripts_dir]}/download_vendor_artifacts.erb"
  variables(
    :aws_access_key_id => node[:core][:aws_access_key_id],
    :aws_secret_access_key => node[:core][:aws_secret_access_key],
    :s3_bucket => node[:core][:s3_bucket],
    :s3_repository => 'Vendor',
    :product => 'jdk',
    :version => '1.7.0',
    :artifacts => artifact,
    :target_directory => download_directory
  )
end

if node[:platform] == 'ubuntu'
  bash 'Download and install jdk' do
    code <<-EOF
      ruby #{node[:ruby_scripts_dir]}/download_jdk.rb
      unzip -d /jdk #{download_directory}/#{artifact}.zip

      echo "JAVA_HOME=/jdk/jdk1.7.0_07" >> /etc/profile
      echo "JRE_HOME=/jdk/jdk1.7.0_07" >> /etc/profile
      echo "PATH=\$PATH:/jdk/jdk1.7.0_07/bin" >> /etc/profile

      rm /usr/bin/java
      rm /usr/bin/javac
      rm /usr/bin/javadoc
      rm /usr/bin/javah
      rm /usr/bin/javap
      rm /usr/bin/java_vm
      rm /usr/bin/javaws
      rm /usr/bin/jcontrol

      ln -s /jdk/jdk1.7.0_07/bin/java /usr/bin/java
      ln -s /jdk/jdk1.7.0_07/bin/javac /usr/bin/javac
      ln -s /jdk/jdk1.7.0_07/bin/javadoc /usr/bin/javadoc
      ln -s /jdk/jdk1.7.0_07/bin/javah /usr/bin/javah
      ln -s /jdk/jdk1.7.0_07/bin/javap /usr/bin/javap
      ln -s /jdk/jdk1.7.0_07/jre/bin/java_vm /usr/bin/java_vm
      ln -s /jdk/jdk1.7.0_07/bin/javaws /usr/bin/javaws
      ln -s /jdk/jdk1.7.0_07/bin/jcontrol /usr/bin/jcontrol

      echo '*** done installing sdk'
    EOF
    not_if { File.exist?("#{download_directory}/#{artifact}.zip") }
  end
else
  powershell 'Downloading jdk' do
    code("ruby #{node[:ruby_scripts_dir]}/download_jdk.rb")
    not_if { File.exist?("#{download_directory}/#{artifact}.zip") }
  end

  windows_zipfile "#{download_directory}/#{artifact}" do
    source "#{download_directory}/#{artifact}.zip"
    action :unzip
    not_if { File.exist?("#{download_directory}/#{artifact}") }
  end

  powershell 'Installing jdk' do
    script = <<-EOF
      cd /installs/jdk_windows
      cmd /c 'msiexec.exe /i jdk1.7.0_07.msi /qn INSTALLDIR=c:\\jdk'
    EOF
    code(script)
    not_if { File.exist?(install_directory) }
  end

  env('JAVA_HOME') { value 'c:\jdk' }
  env('JRE_HOME') { value 'c:\jdk' }

  env('PATH') do
    action :modify
    delim ::File::PATH_SEPARATOR
    value 'c:\jdk\bin'
  end
end
