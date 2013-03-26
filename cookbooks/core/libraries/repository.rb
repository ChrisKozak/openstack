module Repository

  def download_vendor(product, version, artifacts, unzip_directory)
    download(artifacts, product, version)
    unzip(artifacts, unzip_directory)
  end

  def download(artifacts, product, version)
    target_directory = node[:installs_directory]

    artifacts.split(',').each do |artifact|
      ruby_block "Download #{product}" do
        block do
          Dir.mkdir(target_directory) unless target_directory.empty? || Dir.exists?(target_directory)

          repository = "\\\\denver2\\Groups\\Build and Deployment\\repository"
          `net use \\\\denver2\\groups /user:devcorp\\svc.tv teamv`

          `xcopy "#{repository}\\vendor\\#{product}\\#{version}\\#{artifact}.zip" #{target_directory}`
          `net use \\\\denver2\\groups /delete`
        end
        not_if { File.exists?("#{target_directory}/#{artifact}.zip") }
      end
    end
  end

  def unzip(artifacts, unzip_directory)
    artifacts.split(',').each do |artifact|
      windows_zipfile unzip_directory do
        source "#{node[:installs_directory]}/#{artifact}.zip"
        action :unzip
        not_if { Dir.exists?(unzip_directory) }
      end
    end
  end

end

class Chef
  class Recipe
    include Repository
  end
end

class Chef
  class Resource
    include Repository
  end
end