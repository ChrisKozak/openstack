artifact = 'nant'

download_vendor(artifact, '0.91a2', artifact, "#{ENV['ProgramW6432']}\\#{artifact}")

env 'PATH' do
  action :modify
  delim ::File::PATH_SEPARATOR
  value "#{ENV['ProgramW6432']}\\#{artifact}\\bin"
end