installs_directory = '/installs'
Dir.mkdir(installs_directory) unless File.exist?(installs_directory)

cookbook_file "#{installs_directory}/winhttpcertcfg.msi" do
  source 'winhttpcertcfg.msi'
end

execute 'Install winhttpcertcfg' do
  command 'winhttpcertcfg.msi /quiet'
  cwd installs_directory
end
