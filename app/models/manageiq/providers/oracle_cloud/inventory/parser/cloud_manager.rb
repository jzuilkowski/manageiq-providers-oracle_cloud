class ManageIQ::Providers::OracleCloud::Inventory::Parser::CloudManager < ManagerRefresh::Inventory::Parser
  def parse
    vms
  end

  def vms
   collector.vms.each do |inventory|
      id = inventory.id.to_s
      name = inventory.name
      location = inventory.location
      vendor = inventory.vendor
  
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("=========Parser====================\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("inventory.id: ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write(id) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("inventory.name: ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write(name) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("inventory.location: ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write(location) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("inventory.vendor: ") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write(vendor) }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("\n") }
      File.open("/home/jonz/RubymineProjects/tmp/manageiq/log/parser.txt", 'a+') {|f| f.write("\n=========Parser====================\n") }
      inventory_object = persister.vms.find_or_build(id)
      inventory_object.name = name
      inventory_object.location = location
      inventory_object.vendor = vendor

    end
  end

end
