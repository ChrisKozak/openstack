module Repository

  def download_vendor(options)
    options = {
      artifacts: options[:product],
      unzip_directory: "#{node[:installs_directory]}\\#{options[:product]}",
    }.merge options
    download(options)
    unzip(options)
  end

  def download(options)
    target_directory = node[:installs_directory]

    options[:artifacts].split(',').each do |artifact|
      ruby_block "Download #{options[:product]}" do
        block do
          Dir.mkdir(target_directory) unless target_directory.empty? || Dir.exists?(target_directory)

          repository = "\\\\denver2\\Groups\\Build and Deployment\\repository"
          `net use \\\\denver2\\groups /user:devcorp\\svc.tv teamv`

          `xcopy "#{repository}\\vendor\\#{options[:product]}\\#{options[:version]}\\#{artifact}.zip" #{target_directory}`
          `net use \\\\denver2\\groups /delete`
        end
        not_if { File.exists?("#{target_directory}/#{artifact}.zip") }
      end
    end
  end

  def unzip(options)
    options[:artifacts].split(',').each do |artifact|
      windows_zipfile options[:unzip_directory] do
        source "#{node[:installs_directory]}/#{artifact}.zip"
        action :unzip
        not_if { Dir.exists?(options[:unzip_directory]) }
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