class ManageIQ::Providers::OracleCloud::CloudManager::RefreshWorker < MiqEmsRefreshWorker
  require_nested :Runner

  def self.ems_class
    parent
  end

end
