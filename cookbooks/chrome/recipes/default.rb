directory node[:chrome][:installs_directory] do
  action :create
  recursive true
end

#todo: download from s3 instead of cookbook file
#cookbook_file "#{installs_directory}\\GoogleChromeStandaloneEnterprise.msi" do
#  source 'GoogleChromeStandaloneEnterprise.msi'
#  not_if { File.exist?("#{installs_directory}\\GoogleChromeStandaloneEnterprise.msi") }
#end

windows_registry 'HKEY_LOCAL_MACHINE\Software\Policies\Google\Update' do
  values 'AutoUpdateCheckPeriodMinutes' => '0'
end

windows_registry 'HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome' do
  values(
    'HomepageIsNewTabPage' => 1,
    'RestoreOnStartup' => 0,
    'DefaultBrowserSettingEnabled' => 0,
    'DefaultSearchProviderEnabled' => 0
  )
end

windows_package 'Google Chrome' do
  source("#{node[:chrome][:installs_directory]}\\GoogleChromeStandaloneEnterprise.msi")
  options '/qn'
end
