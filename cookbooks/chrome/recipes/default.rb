directory node[:chrome][:installs_directory] do
  action :create
  recursive true
end

remote_file "#{default[:chrome][:installs_directory]}\\GoogleChromeStandaloneEnterprise.msi" do
  source 'https://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
  action :create
end

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
