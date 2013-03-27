product = 'nant'

download_vendor(product: product, version: '0.91a2', unzip_directory: "#{ENV['ProgramW6432']}\\#{product}")

env 'PATH' do
  action :modify
  delim ::File::PATH_SEPARATOR
  value "#{ENV['ProgramW6432']}\\#{product}\\bin"
end