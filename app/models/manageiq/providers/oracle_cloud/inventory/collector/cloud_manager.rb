class ManageIQ::Providers::OracleCloud::Inventory::Collector::CloudManager < ManagerRefresh::Inventory::Collector
  def connection
    @connection ||= manager.connect
  end

  def vms
    instances = connection.instances.all
    results = []
    instances.each_with_index do |item, _index|

      id = (instances.get(item.name).name).rpartition('/').last
      name = instances.get(item.name).name
      location = 'us2'
      vendor = 'unknown'

      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("=========Collector====================\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(":id => ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(id) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(":name => ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(name) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(":location => ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(location) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(":vendor => ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write(vendor) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/collector.txt", 'a+') {|f| f.write("=========Collector====================\n") }
	
      results.push(OpenStruct.new(:id =>  id,
                                  :name => name,
                                  :location => location,
		                  :vendor => vendor
		                  ))
    end
    results
  end
end
